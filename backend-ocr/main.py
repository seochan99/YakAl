# Description: 이미지를 입력받아 약이름을 추출하는 모듈
from functions.show_image import show_image
from functions.marge_images import marge_images
from functions.image_to_text import image_to_text
from functions.after_processing import after_processing
from functions.search_mysql import search_mysql

def image_to_doses(image_path):
    # 이미지를 네이버 OCR API에 전송하여 텍스트 추출
    before_result = image_to_text('resources/images/image_4.png')
    after_result = after_processing(before_result)
    
    # mysql에서 약이름 검색
    mysql_result = search_mysql(after_result)
    return mysql_result