import * as S from "./style.ts";
import PatientNotFound from "./child/patient-not-found/view.tsx";
import SpecialNote from "./child/notes/view.tsx";
import Doses from "./child/doses/view.tsx";
import Questionnaires from "./child/questionnaires/view.tsx";
import Prescriptions from "./child/prescriptions/view.tsx";
import HealthFunctionalFoods from "./child/health-functional-foods/view.tsx";

import MaleOutlinedIcon from "@mui/icons-material/MaleOutlined";
import FemaleOutlinedIcon from "@mui/icons-material/FemaleOutlined";
import { useMediaQuery } from "react-responsive";
import getAge from "../../../../util/get-age.ts";
import { ESex } from "../../../../type/sex.ts";
import { useLocation } from "react-router-dom";
import { ErrorMain, ErrorOuter } from "../patient-list/style.ts";

type TParam = {
  id: number;
  name: string;
  sex: ESex;
  birthday: number[];
};

function PatientPage() {
  const isMobile = useMediaQuery({ query: "(max-width: 480px)" });

  const location = useLocation();
  const userInfo = location.state as TParam;

  if (!userInfo && !localStorage.getItem("id")) {
    return (
      <ErrorOuter>
        <S.Header>
          <S.BackButton to="/expert/patient">
            <S.BackIcon />
            환자 목록으로
          </S.BackButton>
        </S.Header>
        <ErrorMain>
          <PatientNotFound text="해당 환자에 대한 정보가 없습니다." />
        </ErrorMain>
      </ErrorOuter>
    );
  }

  localStorage.setItem("id", userInfo.id.toString());
  localStorage.setItem("name", userInfo.name);
  localStorage.setItem("sex", userInfo.sex.toString());
  localStorage.setItem("year", userInfo.birthday[0].toString());
  localStorage.setItem("month", userInfo.birthday[1].toString());
  localStorage.setItem("date", userInfo.birthday[2].toString());

  const id = localStorage.getItem("id") as string;
  const name = localStorage.getItem("name") as string;
  const sex = ESex[localStorage.getItem("sex") as keyof typeof ESex];
  const year = Number(localStorage.getItem("year"));
  const month = Number(localStorage.getItem("month"));
  const date = Number(localStorage.getItem("date"));

  return (
    <S.Outer>
      <S.Header>
        <S.BackButton to="/expert/patient">
          <S.BackIcon />
          환자 목록으로
        </S.BackButton>
      </S.Header>
      <S.PatientSummary>
        <S.NameSex>
          <S.Name>{name}</S.Name>
          <S.Sex>
            {sex === ESex.MALE ? "남성" : "여성"}
            {sex === ESex.MALE ? <MaleOutlinedIcon /> : <FemaleOutlinedIcon />}
          </S.Sex>
        </S.NameSex>
        <S.Birthday>
          {`${year}.
          ${month < 10 ? "0".concat(month.toString()) : month}.
          ${date < 10 ? "0".concat(date.toString()) : date}. `}
          {!isMobile && `(${getAge(new Date(year, month - 1, date))}세)`}
        </S.Birthday>
      </S.PatientSummary>
      <S.NoteAndDoseList>
        <S.InnerBox>
          <SpecialNote patientId={Number(id)} />
        </S.InnerBox>
        <S.InnerBox>
          <Doses patientId={Number(id)} />
        </S.InnerBox>
      </S.NoteAndDoseList>
      <S.InnerBox>
        <Questionnaires patientId={Number(id)} />
      </S.InnerBox>
      <S.PrescriptionAndHealthFunctionalFood>
        <S.InnerBox>
          <Prescriptions patientId={Number(id)} />
        </S.InnerBox>
        <S.InnerBox>
          <HealthFunctionalFoods patientId={Number(id)} />
        </S.InnerBox>
      </S.PrescriptionAndHealthFunctionalFood>
    </S.Outer>
  );
}

export default PatientPage;
