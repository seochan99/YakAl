import React, { useEffect, useRef, useState } from "react";
import * as S from "./style.ts";
import ReactDatePicker from "react-datepicker";
import "react-datepicker/dist/react-datepicker.css"; // Import the styles for react-datepicker

import { authAxios } from "@/api/auth/instance.ts";

import { Chart, registerables } from "chart.js";
Chart.register(...registerables);

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

  // 날짜 목록에 따라 약물 리스트 가져오기
  useEffect(() => {}, [medicineList]);

  // 날짜 포멧 스티링으로 셋팅
  const formatDate = (date: Date): string => {
    const year = date.getFullYear();
    const month = (date.getMonth() + 1).toString().padStart(2, "0");
    const day = date.getDate().toString().padStart(2, "0");
    return `${year}-${month}-${day}`;
  };

  // 약물 목록 fetch하기
  const fetchMedicineList = async (startDate: String, endDate: String) => {
    try {
      // const response = await authAxios.get(`admin/doses/between?startDate=${startDate}&endDate=${endDate}`);
      // if (response.data.success) {
      //   setMedicineList(response.data.data.result);
      // }
      const dummyData: Medicine[] = [
        { name: "타이레놀", cnt: 50, kdCode: "1234" },
        { name: "크앙", cnt: 40, kdCode: "1234" },
        { name: "크허ㅓㅎ엉", cnt: 30, kdCode: "1234" },
        { name: "푸하앙", cnt: 20, kdCode: "1234" },
        { name: "우아악", cnt: 18, kdCode: "1234" },
        { name: "므먕ㅁ", cnt: 17, kdCode: "1234" },
        { name: "먀먕", cnt: 15, kdCode: "1234" },
        { name: "모묭", cnt: 12, kdCode: "1234" },
        { name: "노뇽", cnt: 10, kdCode: "1234" },
        { name: "흐하", cnt: 5, kdCode: "1234" },
      ];
      setMedicineList(dummyData);
    } catch (e) {
      console.log(e);
    }
  };
  // 색상 무작위 생성
  function randomRGBA(opacity: number) {
    let o = opacity || 1;
    return `rgba(${Math.floor(Math.random() * 255)}, ${Math.floor(Math.random() * 255)}, ${Math.floor(
      Math.random() * 255,
    )}, ${o})`;
  }

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
  }, [medicineList]);

  // 날짜 선택후 검색하기
  const handleSearch = () => {
    if (startDate && endDate) {
      fetchMedicineList(formatDate(startDate), formatDate(endDate));
    } else {
      alert("올바른 날짜를 선택해주세요!");
    }
  };

  const renderMedicineChart = () => {
    return medicineList.length > 0 ? (
      <S.SearchResultContainer>
        <canvas ref={chartRef} id="myChart" width="400" height="400"></canvas>
      </S.SearchResultContainer>
    ) : (
      <S.SearchResultContainer>검색버튼을 통해 복용통계를 확인해보세요!</S.SearchResultContainer>
    );
  };

  return (
    <>
      <S.MedicineListContainer>
        <S.HeaderTitle>유저가 많이 복용한 약물</S.HeaderTitle>
        {/* ----------------날짜 컨테이너 ----------------*/}
        <S.DateContainer>
          <ReactDatePicker
            selected={startDate}
            dateFormat="yyyy.MM.dd" // Display format
            onChange={(date) => setStartDate(date)}
            selectsStart
            shouldCloseOnSelect
            startDate={startDate}
            minDate={new Date("2023-10-01")}
            maxDate={endDate}
            placeholderText="시작 날짜"
          />
          <ReactDatePicker
            selected={endDate}
            dateFormat="yyyy.MM.dd" // Display format
            onChange={(date) => setEndDate(date)}
            selectsEnd
            shouldCloseOnSelect
            endDate={endDate}
            minDate={startDate}
            maxDate={new Date()}
            placeholderText="끝 날짜"
          />
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
