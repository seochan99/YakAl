import {
  BackButton,
  BackIcon,
  Birthday,
  Header,
  InnerBox,
  Name,
  NameSex,
  NoteAndDoseList,
  Outer,
  PatientSummary,
  PrescriptionAndHealthFunctionalFood,
  Sex,
} from "./style.ts";
import PatientInfoText from "./child/patient-info-text";
import SpecialNote from "./child/special-note";
import DoseList from "./child/dose-list";
import SurveyResult from "./child/survey-result";
import PrescriptionList from "./child/prescription-list";
import HealthFoodList from "./child/health-food-list";

import MaleOutlinedIcon from "@mui/icons-material/MaleOutlined";
import FemaleOutlinedIcon from "@mui/icons-material/FemaleOutlined";
import { useMediaQuery } from "react-responsive";
import getAge from "../../../util/get-age.ts";
import { ESex } from "../../../type/sex.ts";
import { useLocation } from "react-router-dom";
import { ErrorMain, ErrorOuter } from "../patient-list/style.ts";

type TParam = {
  id: number;
  name: string;
  sex: ESex;
  birthday: number[];
};

function PatientInfo() {
  const isMobile = useMediaQuery({ query: "(max-width: 480px)" });

  const location = useLocation();
  const userInfo = location.state as TParam;

  if (!userInfo && !localStorage.getItem("id")) {
    return (
      <ErrorOuter>
        <Header>
          <BackButton to="/expert/patient">
            <BackIcon />
            환자 목록으로
          </BackButton>
        </Header>
        <ErrorMain>
          <PatientInfoText text="해당 환자에 대한 정보가 없습니다." />
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
    <Outer>
      <Header>
        <BackButton to="/expert/patient">
          <BackIcon />
          환자 목록으로
        </BackButton>
      </Header>
      <PatientSummary>
        <NameSex>
          <Name>{name}</Name>
          <Sex>
            {sex === ESex.MALE ? "남성" : "여성"}
            {sex === ESex.MALE ? <MaleOutlinedIcon /> : <FemaleOutlinedIcon />}
          </Sex>
        </NameSex>
        <Birthday>
          {`${year}.
          ${month < 10 ? "0".concat(month.toString()) : month}.
          ${date < 10 ? "0".concat(date.toString()) : date}. `}
          {!isMobile && `(${getAge(new Date(year, month - 1, date))}세)`}
        </Birthday>
      </PatientSummary>
      <NoteAndDoseList>
        <InnerBox>
          <SpecialNote patientId={Number(id)} />
        </InnerBox>
        <InnerBox>
          <DoseList />
        </InnerBox>
      </NoteAndDoseList>
      <InnerBox>
        <SurveyResult />
      </InnerBox>
      <PrescriptionAndHealthFunctionalFood>
        <InnerBox>
          <PrescriptionList />
        </InnerBox>
        <InnerBox>
          <HealthFoodList />
        </InnerBox>
      </PrescriptionAndHealthFunctionalFood>
    </Outer>
  );
}

export default PatientInfo;
