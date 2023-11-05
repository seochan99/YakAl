import os
import re
from dotenv import load_dotenv

def after_processing(before_result: list):
    # dotenv에서 LAST_DOSE_LIST 가져와서 , 기준으로 split하고 공백 제거
    LAST_DOSE_CHAR = os.getenv('LAST_DOSE_LIST').split(',')
    LAST_DOSE_CHAR = [x.strip() for x in LAST_DOSE_CHAR]

    # result(String List)에서 공백 제거
    middle_result = [re.sub(r"\s+", "", x) for x in before_result]

    # result(String List)에서 정규식에서 (을 만나면 (을 기준으로 앞의 문자열만 남기고 삭제
    middle_result = [re.sub(r"\(.+", "(", x) for x in middle_result]

    # result(String List)에서 한글, 숫자, 'mg', 'Mg', 'mG', 'MG' 외의 모든 문자 제거
    # re.IGNORECASE를 사용하여 대소문자 구분 없앰
    middle_result = [re.sub(r"[^가-힣0-9mMgG]", "", x, flags=re.IGNORECASE) for x in middle_result]
    
    ## -가 들어있는 단어는 삭제
    middle_result = [x for x in middle_result if not re.match(r".+-", x)]
    
    ## 숫자만 있다면 삭제
    middle_result = [x for x in middle_result if not re.match(r"^[0-9]+$", x)]

    # result(String List)에서 String의 길이가 2글자 이하는 삭제
    middle_result = [x for x in middle_result if len(x) > 2]

    # last_char list에 있는 2글자로 끝나는 단어만 추출
    after_result = [x for x in middle_result if x.endswith(tuple(LAST_DOSE_CHAR))]
    
    return after_result