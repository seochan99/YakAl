from typing import Set, List, Union, Tuple

from fuzzywuzzy import fuzz
from difflib import SequenceMatcher
from imutils.contours import sort_contours
from imutils.perspective import four_point_transform
import matplotlib.pyplot as plt
import pytesseract
import imutils
import cv2
import numpy as np
import time

import easyocr

# 이미지 출력 함수
def plt_imshow(title: Union[str, List] = 'image',
               img: Union[np.ndarray, List[np.ndarray]] = None,
               figsize: Tuple[int, int] = (16, 10)):
    plt.figure(figsize=figsize)

    if type(img) == list:
        if type(title) == list:
            titles = title
        else:
            titles = []

            for i in range(len(img)):
                titles.append(title)

        for i in range(len(img)):
            if len(img[i].shape) <= 2:
                rgbImg = cv2.cvtColor(img[i], cv2.COLOR_GRAY2RGB)
            else:
                rgbImg = cv2.cvtColor(img[i], cv2.COLOR_BGR2RGB)

            plt.subplot(1, len(img), i + 1), plt.imshow(rgbImg)
            plt.title(titles[i])
            plt.xticks([]), plt.yticks([])

        plt.show()
    else:
        if len(img.shape) < 3:
            rgbImg = cv2.cvtColor(img, cv2.COLOR_GRAY2RGB)
        else:
            rgbImg = cv2.cvtColor(img, cv2.COLOR_BGR2RGB)

        plt.imshow(rgbImg)
        plt.title(title)
        plt.xticks([]), plt.yticks([])
        plt.show()

# 이미지 두 개를 위아래 방향으로 합치는 함수, 너비는 큰쪽을 따라간다.
def marge_image(img1: np.ndarray, img2: np.ndarray, gap: int = 10) -> np.ndarray:
    """
    Concatenate two numpy.ndarray images in the longitudinal direction.
    The width of concatenated image is of the wider one.
    The margin on the less-wide image is filled with white(255, 255, 255).
    if img1 is empty array, second one could be returned.

    :param img1: top image
    :param img2: bottom image
    :type img1: np.ndarray
    :type img2: np.ndarray
    :return: The concatenated image
    :rtype: np.ndarray
    """

    if img1.size == 0:
        return img2

    width, img = (img1.shape[1], img1) if img1.shape[1] > img2.shape[1] else (img2.shape[1], img2)

    if np.array_equal(img, img1):
        img2 = cv2.copyMakeBorder(img2, top=gap, bottom=0, left=0, right=img1.shape[1] - img2.shape[1],
                                  borderType=cv2.BORDER_CONSTANT, value=(255, 255, 255))
    else:
        img1 = cv2.copyMakeBorder(img1, top=0, bottom=gap, left=0, right=img2.shape[1] - img1.shape[1],
                                  borderType=cv2.BORDER_CONSTANT, value=(255, 255, 255))

    return np.concatenate((img1, img2), axis=0)


# OCR 하는 함수 (path : 경로, vervose : 이미지 출력 여부)
def ocr_prescription(path: str, verbose: bool = False):
    # 시간 측정 시작
    start = time.time()

    # 1. Image Loading 
    org = cv2.imread(path)

    if verbose:
        plt_imshow("Original", org, figsize=(32, 20))

    # 2. Prescription Edge Detection (처방전 틀 검출)
    preprocessed = org
    H, W, _ = preprocessed.shape

    if verbose:
        plt_imshow("Preprocessed", preprocessed)
        
    
    # 3. Histogram Equalization (히스토그램 평탄화 부분)
    #--① 컬러 스케일을 BGR에서 YUV로 변경
    img_yuv = cv2.cvtColor(org, cv2.COLOR_BGR2YUV) 

    #--② 밝기 채널에 대해서 이퀄라이즈 적용
    img_eq = img_yuv.copy()
    img_eq[:,:,0] = cv2.equalizeHist(img_eq[:,:,0])
    img_eq = cv2.cvtColor(img_eq, cv2.COLOR_YUV2BGR)
    
    #--③ 밝기 채널에 대해서 CLAHE 적용
    img_clahe = img_yuv.copy()
    clahe = cv2.createCLAHE(clipLimit=1.3, tileGridSize=(8,8)) #CLAHE 생성
    img_clahe[:,:,0] = clahe.apply(img_clahe[:,:,0])           #CLAHE 적용
    img_clahe = cv2.cvtColor(img_clahe, cv2.COLOR_YUV2BGR)
    
    #--④ 결과 출력
    plt_imshow('Before', org)
    plt_imshow('CLAHE', img_clahe)
    plt_imshow('equalizeHist', img_eq)
    
    # 4. 회전 변환 시작
    
    # Canny 엣지 검출
    img_gray = cv2.cvtColor(img_clahe, cv2.COLOR_BGR2GRAY)
    edges = cv2.Canny(img_gray, threshold1=50, threshold2=150)

    # Hough 변환을 이용한 선분 검출 (사진에서 선분들 검출)
    lines = cv2.HoughLinesP(edges, 1, np.pi / 180, threshold=100, minLineLength=100, maxLineGap=10)

    # 선분 필터링을 위한 기울기 범위 설정 (범위 내 선분들만 선택하기 위한 설정)
    min_angle = -30  # 일정 기울기 범위 최소값 (예: -30도)
    max_angle = 30   # 일정 기울기 범위 최대값 (예: 30도)
    angle_interval = 5  # 기울기 간격 설정 (5도 간격으로 필터링) (추출한 선분들을 지정 간격으로 그룹화해서 묶음)
    
    filtered_lines = []
    
    for line in lines:
        x1, y1, x2, y2 = line[0]
        angle = np.arctan2(y2 - y1, x2 - x1) * 180 / np.pi  #기울기 측정
    
        if min_angle <= angle <= max_angle: #위에서 지정한 선분들만 선택
            # 기울기 간격에 따라 필터링된 선분 저장
            angle_rounded = round(angle / angle_interval) * angle_interval #위에서 지정한 기울기 간격에 맞춰 기울기 반올림
            filtered_lines.append((x1, y1, x2, y2, angle_rounded)) #필터링한 선분들만 반올림한 기울기 정보 추가해서 같이 저장
    
    
    # 기울기별로 선분 저장할 딕셔너리 생성
    angle_lines_dict = {angle: [] for angle in range(min_angle, max_angle + 1, angle_interval)}

    for line in filtered_lines:
        _, _, _, _, angle_rounded = line
        angle_lines_dict[angle_rounded].append(line) #기울기 간격별로 선분들 그룹화(여기서는 5도 간격)

    # 가장 많은 선분을 포함한 각도 찾기
    most_common_angle = max(angle_lines_dict, key=lambda k: len(angle_lines_dict[k]))

    # 가장 많은 선분을 포함한 각도로 회전 보정
    angle = most_common_angle
    
    # 이미지 중심점 찾기
    height, width = img_gray.shape
    center = (width // 2, height // 2)

    # 회전 변환 매트릭스 생성
    rotation_matrix = cv2.getRotationMatrix2D(center, angle, scale=1.0)

    # 이미지 회전
    rotated_image = cv2.warpAffine(img_gray, rotation_matrix, (width, height))
    

    # 결과 출력
    plt_imshow('Original Image', img_gray)
    plt_imshow('Rotated Image', rotated_image)
    
    
    # Histogram 생성 (히스토그램 정규화 하는 과정 그래프로 보여주는거 굳이 할 필요 없음)
    hist = cv2.calcHist([rotated_image],[0],None,[256], [0, 256])
    plt.plot(hist)
    
    if verbose:
        print("hist.shape:", hist.shape)
        print("hist.sum():", hist.sum(), "img.shape:",rotated_image.shape)
        plt.show()
        
    #5 Histogram Normalize (히스토그램 정규화)
    
    img_norm2 = cv2.normalize(rotated_image, None, 0, 255, cv2.NORM_MINMAX) #이거 하나로 바로 정규화
    
    # 위에서 히스토그램 과정 그래프 생성하는거 이것도 굳이 할 필요 없음    
    hist = cv2.calcHist([rotated_image], [0], None, [256], [0, 255])
    hist_norm2 = cv2.calcHist([rotated_image], [0], None, [256], [0, 255])
    
    # 이미지 출력
    if verbose:
        plt_imshow('Before', rotated_image)
        plt_imshow('cv2.normalize()', img_norm2)
        # hists = {'Before' : hist, 'cv2.normalize()':hist_norm2}
        # for i, (k, v) in enumerate(hists.items()):
        #     plt.subplot(1,3,i+1)
        #     plt.title(k)
        #     plt.plot(v)
        # plt.show()

    

    # 3. Gray Scale Grouping
    #gray: np.ndarray = cv2.cvtColor(img_norm2, cv2.COLOR_BGR2GRAY)
    gray = img_norm2
    if verbose:
        plt_imshow("Gray", gray)

    # 커널 크기 지정
    ksize = W // 768
    ksize = ksize if ksize % 2 == 1 else ksize + 1 # 홀수면 짝수로 만들어줌
    ksize = 3 if ksize < 3 else ksize # 최소 3

    if verbose:
        print("ksize: ", ksize)

    ellipse_kernel = cv2.getStructuringElement(cv2.MORPH_ELLIPSE, (ksize, ksize)) # 타원형 커널 생성
    grad = cv2.morphologyEx(gray, cv2.MORPH_GRADIENT, ellipse_kernel) # 이미지 엣지 검출
    _, bw = cv2.threshold(grad, 0.0, 255.0, cv2.THRESH_BINARY | cv2.THRESH_OTSU) # 이미지를 이진화 해 흑백 처리

    rect_kernel = cv2.getStructuringElement(cv2.MORPH_RECT, (ksize * 4, 1)) #직사각형 형태 커널 생성
    closed = cv2.morphologyEx(bw, cv2.MORPH_CLOSE, rect_kernel) # 모폴로지 닫힘 연산 수행
    # 타원형 + 직사각형 두번 해서 다양한 특징을 찾는다고 함(아마도..?)
    
    if verbose:
        plt_imshow("Closed", closed)
        
    

    # 4. Text Edge Detection
    # 윤곽선 찾기
    contours = cv2.findContours(closed.copy(), cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_NONE)
    contours = imutils.grab_contours(contours) #버전 차이 보완
    contours = sort_contours(contours, method="top-to-bottom")[0] # 윤곽선 정렬

    roi_list = []
    roi_title_list = []

    grouped: np.ndarray = img_norm2.copy()

    bsize = W // 96
    bsize = bsize if bsize % 2 == 1 else bsize + 1
    bsize = 11 if bsize < 11 else bsize

    w_crit = W // 256
    h_crit = H // 108
    gap = w_crit * 4

    if verbose:
        print("block size: ", bsize)
        print("w_crit: ", w_crit)
        print("h_crit: ", h_crit)
        print("gap: ", gap)

    for c in contours: # 해당 윤곽선을 감싸는 가장 작은 사각형 정보 들고옴
        (x, y, w, h) = cv2.boundingRect(c)

        # Calculate the maximum allowed box size based on image height(최대 허용 너비+ 최대 허용 높이 계산)
        max_allowed_width = img_norm2.shape[1] * 0.2
        max_allowed_height = img_norm2.shape[0] * 0.05
        #print(max_allowed_width, max_allowed_height)
        
        # 크기가 적당할 때만 검사
        if w_crit < w and h_crit < h < h_crit * 16:
            # Skip if the bounding box is too large
            if w > max_allowed_width or h > max_allowed_height:
                continue
            # 유요한 윤곽선이면 추출
            color = (0, 0, 255)
            roi = gray[y: (y + h), x: (x + w)]
            
            # 임계값 처리
            roi = cv2.adaptiveThreshold(roi, 255, cv2.ADAPTIVE_THRESH_GAUSSIAN_C, cv2.THRESH_BINARY, bsize, 10)
            roi_list.append(roi) # 배열에 저장
            roi_title_list.append("Roi_{}".format(len(roi_list)))
        else:
            color = (255, 0, 0)
            
        # 유요한 윤곽선 주변에 사각형 보여줌(text 주변에 네모 보여주는거)
        cv2.rectangle(grouped, (x, y), (x + w, y + h), color=color, thickness=3)
        cv2.putText(grouped, "(" + str(w) + ", " + str(h) + ")", (x, y - 10), cv2.FONT_HERSHEY_SIMPLEX, fontScale=1, color=color, thickness=3)

    if verbose:
        plt_imshow("Grouped", grouped)

    # 5. OCR
    merged = np.array([])
    result = []
    last = len(roi_list) - 1
    reader = easyocr.Reader(['ko','en'], gpu=True)

    for idx, roi in enumerate(roi_list): # 나눴던 이미지 다시 합침
        merged = marge_image(merged, roi, gap)

        if idx % 15 == 14 or idx == last:
            # 이미지에 여백 넣어서 틀어진거 맞춤
            merged = cv2.copyMakeBorder(merged, top=gap, bottom=gap, left=gap, right=gap, borderType=cv2.BORDER_CONSTANT,
                                        value=(255, 255, 255))

            if verbose:
                plt_imshow("Merged", merged)

            #result.append(pytesseract.image_to_string(merged, config="--psm 4 --oem 1 -l kor"))
            # reader.readtext로 읽은 결과
            readtext_results = reader.readtext(merged)
            if len(readtext_results) > 0:  # 인식된 텍스트가 있는 경우에만 처리
                for readtext in readtext_results:
                    # result는 (text, bbox, prob) 형식의 튜플
                    text = readtext[1]  # 읽은 텍스트
                    result.append(text) # 읽은 텍스트들 저장
                
            merged = np.array([])

    words = "".join(result).splitlines() # 줄 바꿈 기준으로 나눔
    words = [word for word in words if word != ""]

    print(result)
    
    query = set(words) #중복 제거

    medicines = ["알레그라정", "스토가정", "가나칸정", "아낙정", "가나릴정", "네가박트정", "에스오메정", "영풍오플록사신정", "바나건조시럽", "동아카나마이신황", "메나탄주",
                 "아가브론시럽", "올메텍플러스정", "한미아스피린장용정", "바난정", "레보프라이드", "싸이메트정", "비졸본정", "록소날", "타이레놀이알서방정", "뮤테란캅셀",
                 "종근당아목시실린캡슐", "코푸시럽", "어린이부루펜시럽", "바리다제정", "세파로캡슐", "아세클낙정", "스토엠정"]
    result_set = set()  # 결과를 담을 집합(set) 생성
    
    
    for q in query: # 중복 까지 제거한 단어들 차례로 봄
        most_similar: Union[None, str] = None
        similarity: int = 0
    
        for medicine in medicines: # 약들 한번씩 보면서 비교
            q_cleaned = "".join(ch for ch in q if ord('가') <= ord(ch) <= ord('힣')) #현재 글자가 유효
            if len(q_cleaned) < len(medicine) * 0.8: # 지금 비교하는 약이름과 길이가 너무 차이나면 건너뜀
                continue
    
            ratio = fuzz.partial_ratio(q_cleaned, medicine)
    
            if ratio >= 70: # 유사도가 일정 이상이면
                result_set.add(medicine) # 약 추가
            
    
    result_list = list(result_set)  # 집합을 리스트로 변환
    end = time.time()

    print(f"Duration: {end - start:.5f} sec")
    return result_list