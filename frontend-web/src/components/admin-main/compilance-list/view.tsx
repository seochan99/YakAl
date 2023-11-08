import { useEffect, useRef, useState } from "react";
import * as S from "./style.ts";

import { authAxios } from "@/api/auth/instance.ts";

import { Chart, registerables } from "chart.js";
Chart.register(...registerables);

function AdminComplianceList() {
  const [complianceList, setComplianceList] = useState<Number[]>([]);
  const chartRef = useRef<HTMLCanvasElement | null>(null);

  const labelData = ["0~20", "21~40", "41~60", "61~80", "81~100"];

  // 약물 목록 fetch하기
  const fetchComplianceList = async () => {
    try {
      // 호출하기
      //   const response = await authAxios.get(`admin/statistic/arms`);
      //   console.log(response.data.data.result);
      //   if (response.data.success) {
      //     setcomplianceList(response.data.data.result);
      //   }

      // 더미데이터
      const dummyData: Number[] = [40, 10, 30, 20, 50];

      setComplianceList(dummyData);
    } catch (e) {
      console.log(e);
    }
  };

  useEffect(() => {
    fetchComplianceList();
  }, []);

  // 초반에 막대 셋팅
  useEffect(() => {
    if (chartRef.current && complianceList.length > 0) {
      const ctx = chartRef.current.getContext("2d");
      if (ctx) {
        const chart = new Chart(ctx, {
          type: "doughnut",
          data: {
            labels: labelData,
            datasets: [
              {
                label: "복용 순응도",
                data: complianceList,

                borderWidth: 2,
                // 채color
              },
            ],
          },
          options: {
            scales: {
              y: {
                beginAtZero: true,
              },
            },
            animation: {
              duration: 1000, // Duration in milliseconds, for example, 2000ms for a 2 second animation.
              easing: "easeInOutQuad", // The animation easing function.
            },
            // If you want to have an animation on dataset change/update:
            transitions: {
              show: {
                animations: {
                  x: {
                    from: 0,
                  },
                  y: {
                    from: 0,
                  },
                },
              },
              hide: {
                animations: {
                  x: {
                    to: 0,
                  },
                  y: {
                    to: 0,
                  },
                },
              },
            },
          },
        });
        return () => chart.destroy();
      }
    }
  }, [complianceList]);

  //  검색 결과 렌더링
  const renderCompliance = () => {
    return complianceList.length > 0 ? (
      <S.SearchResultContainer>
        <canvas ref={chartRef} id="myChart" width="400" height="400"></canvas>
      </S.SearchResultContainer>
    ) : (
      <S.SearchResultContainer>등록된 복약순응도가 없습니다!</S.SearchResultContainer>
    );
  };

  return (
    <>
      <S.MedicineListContainer>
        <S.HeaderTitle>전체 유저 복약 순응도 통계</S.HeaderTitle>
        {/* ----------------날짜 컨테이너 ----------------*/}
        <S.DateContainer>
          <S.SearchButton onClick={fetchComplianceList}>새로고침</S.SearchButton>
        </S.DateContainer>

        {/* ----------------약물 목록 분석 차트 그리기 ----------------*/}
        <S.SearchResultContainer>{renderCompliance()}</S.SearchResultContainer>

        {/* ----------------약물 목록 분석 차트 그리기 ----------------*/}
      </S.MedicineListContainer>
    </>
  );
}

export default AdminComplianceList;