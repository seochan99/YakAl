import { ButtonHTMLAttributes, forwardRef, useEffect, useRef, useState } from "react";
import * as S from "./style.ts";
import ReactDatePicker from "react-datepicker";
import "react-datepicker/dist/react-datepicker.css"; // Import the styles for react-datepicker
import { Chart, registerables } from "chart.js";
import { authAxios } from "@/api/auth/instance.ts";

Chart.register(...registerables);

interface CustomInputProps extends ButtonHTMLAttributes<HTMLButtonElement> {
  value?: string;
  onClick?: () => void;
}

type Medicine = {
  name: string;
  cnt: number;
  kdCode: string;
};

function AdminStatisticDetail() {
  const [medicineList, setMedicineList] = useState<Medicine[]>([]);
  const [startDate, setStartDate] = useState<Date | null>(null);
  const [endDate, setEndDate] = useState<Date | null>(null);
  const chartRef = useRef<HTMLCanvasElement | null>(null);

  // 날짜 포멧 스티링으로 셋팅
  const formatDate = (date: Date): string => {
    const year = date.getFullYear();
    const month = (date.getMonth() + 1).toString().padStart(2, "0");
    const day = date.getDate().toString().padStart(2, "0");
    return `${year}-${month}-${day}`;
  };

  // 약물 목록 fetch하기
  const fetchMedicineList = async (startDate: string, endDate: string) => {
    try {
      const response = await authAxios.get(`/admins/doses/between?startDate=${startDate}&endDate=${endDate}`);
      setMedicineList(response.data.data);
    } catch (e) {
      setMedicineList([]);
    }
  };

  // 색상 무작위 생성
  function randomRGBA(opacity: number) {
    const o = opacity || 1;
    return `rgba(${Math.floor(Math.random() * 255)}, ${Math.floor(Math.random() * 255)}, ${Math.floor(
      Math.random() * 255,
    )}, ${o})`;
  }

  // 사용자 정의 입력 컴포넌트
  const StartCustomInput = forwardRef<HTMLButtonElement, CustomInputProps>(({ value, onClick }, ref) => (
    <S.CalendarDateBtn onClick={onClick} ref={ref}>
      {value || "시작 날짜 선택"} {/* value가 없으면 placeholder 텍스트 표시 */}
    </S.CalendarDateBtn>
  ));

  const EndCustomInput = forwardRef<HTMLButtonElement, CustomInputProps>(({ value, onClick }, ref) => (
    <S.CalendarDateBtn onClick={onClick} ref={ref}>
      {value || "종료 날짜 선택"} {/* value가 없으면 placeholder 텍스트 표시 */}
    </S.CalendarDateBtn>
  ));

  //
  StartCustomInput.displayName = "CustomInput";
  EndCustomInput.displayName = "CustomInput";
  // 막대 그래프 데이터셋 설정
  const datasets = [
    {
      label: "복용량",
      data: medicineList.map((med) => med.cnt),
      // 각 막대에 대한 무작위 배경색상 생성
      backgroundColor: medicineList.map(() => randomRGBA(0.2)),
      //   // 각 막대에 대한 무작위 테두리색상 생성
      //   borderColor: medicineList.map(() => randomRGBA(1)),
      borderWidth: 1,
    },
  ];

  // 막대 그래프 데이터셋 설정
  useEffect(() => {
    if (chartRef.current && medicineList.length > 0) {
      const ctx = chartRef.current.getContext("2d");

      if (ctx) {
        const chart = new Chart(ctx, {
          type: "bar",
          data: {
            labels: medicineList.map((med) => `${med.name} (${med.kdCode})`),
            datasets: datasets,
          },
          options: {
            scales: {
              y: {
                beginAtZero: true,
              },
            },
          },
        });

        // Clean up the chart to prevent memory leaks
        return () => chart.destroy();
      }
    }
  }, [datasets, medicineList]);

  // 날짜 선택후 검색하기
  const handleSearch = () => {
    if (startDate && endDate) {
      fetchMedicineList(formatDate(startDate), formatDate(endDate));
    } else {
      alert("올바른 날짜를 선택해주세요!");
    }
  };

  //  검색 결과 렌더링
  const renderMedicineChart = () => {
    return medicineList.length > 0 ? (
      <S.SearchResultContainer>
        <canvas ref={chartRef} id="myChart" width="400" height="400"></canvas>
      </S.SearchResultContainer>
    ) : (
      <S.SearchResultContainer>검색버튼을 통해 복용통계를 확인해보세요!</S.SearchResultContainer>
    );
  };

  // 날짜 목록에 따라 약물 리스트 가져오기
  useEffect(() => {
    if (startDate !== null && endDate !== null) {
      fetchMedicineList(formatDate(startDate), formatDate(endDate));
    }
  }, [endDate, medicineList, startDate]);

  return (
    <>
      <S.MedicineListContainer>
        <S.HeaderTitle>{"💊 유저가 많이 복용한 약물"}</S.HeaderTitle>

        <S.DateContainer>
          <S.ColCalendar>
            {/*<S.CalendarLabel>시작 일자</S.CalendarLabel>*/}
            <ReactDatePicker
              selected={startDate}
              dateFormat="yyyy.MM.dd" // Display format
              onChange={(date) => setStartDate(date)}
              selectsStart
              shouldCloseOnSelect
              startDate={startDate}
              minDate={new Date("2023-10-01")}
              maxDate={endDate}
              customInput={<StartCustomInput />}
              placeholderText="시작 날짜"
            />
          </S.ColCalendar>

          <S.ColCalendar>
            {/*<S.CalendarLabel>끝 일자</S.CalendarLabel>*/}
            <ReactDatePicker
              selected={endDate}
              dateFormat="yyyy.MM.dd" // Display format
              onChange={(date) => setEndDate(date)}
              selectsEnd
              shouldCloseOnSelect
              endDate={endDate}
              minDate={startDate}
              maxDate={new Date()}
              customInput={<EndCustomInput />}
              placeholderText="끝 날짜"
            />
          </S.ColCalendar>
        </S.DateContainer>
        {/* ----------------검색 버튼 ----------------*/}
        <S.SearchButton onClick={handleSearch}>검색</S.SearchButton>

        {/* ----------------약물 목록 분석 차트 그리기 ----------------*/}
        <S.SearchResultContainer>{renderMedicineChart()}</S.SearchResultContainer>

        {/* ----------------약물 목록 분석 차트 그리기 ----------------*/}
      </S.MedicineListContainer>
    </>
  );
}

export default AdminStatisticDetail;
