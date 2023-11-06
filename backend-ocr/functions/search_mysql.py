import pymysql
from dto.dose_name import DoseName

def search_mysql(after_result):
    mysql_name_result = []
    mysql_result = []

    conn = pymysql.connect(host='localhost',
                        user='root',
                        password='1234',
                        db='yakal',
                        charset='utf8')

    try:
        with conn.cursor() as cursor:
            sql = """
                SELECT 
                    sub.*, 
                    sub.relevance / max_relevance AS normalized_relevance
                    FROM 
                    (
                        SELECT 
                        fd.*, 
                        MATCH(fd.name) AGAINST(%s IN NATURAL LANGUAGE MODE) AS relevance
                        FROM 
                        ft_dosenames fd
                        WHERE 
                        MATCH(fd.name) AGAINST(%s IN NATURAL LANGUAGE MODE)
                    ) AS sub
                    CROSS JOIN 
                    (
                        SELECT 
                        MAX(MATCH(fd.name) AGAINST(%s IN NATURAL LANGUAGE MODE)) AS max_relevance
                        FROM 
                        ft_dosenames fd
                        WHERE 
                        MATCH(fd.name) AGAINST(%s IN NATURAL LANGUAGE MODE)
                    ) AS max_value
                    WHERE 
                    sub.relevance >= 22
                    ORDER BY 
                    sub.relevance DESC 
                    LIMIT 
                    1 OFFSET 0;
            """
            
            for after_result_tuple in after_result:
                # SQL 쿼리 실행
                cursor.execute(sql, (after_result_tuple, after_result_tuple, after_result_tuple, after_result_tuple))
                
                # DoseName 객체로 변환하여 mysql_result에 추가, DoeseName 객체의 name가 mysql_result의 name에 없을 경우에만 추가
                result = cursor.fetchall()
                if result:
                    for row in result:
                        if row[1] in mysql_name_result:
                            continue
                        
                        dose_name = DoseName(row[1], row[2], row[3])
                        mysql_name_result.append(row[1])
                        mysql_result.append(dose_name)

    finally:
        # 데이터베이스 연결 종료
        conn.close()
    
    return mysql_result