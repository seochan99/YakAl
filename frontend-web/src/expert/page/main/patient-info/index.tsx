import { useLoaderData } from "react-router-dom";
import {
  NameSex,
  Outer,
  PatientSummary,
  Sex,
  InnerBox,
  Name,
  Birthday,
  NoteAndDoseList,
  Header,
  BackButton,
  BackIcon,
  PrescriptionAndHealthFunctionalFood,
} from "./style.ts";
import { TPatientInfoLoaderReturn } from "./loader.ts";
import { ESex } from "@/expert/type/sex.ts";
import getAge from "@/expert/util/get-age.ts";
import PatientInfoText from "./child/patient-info-text";
import SpecialNote from "./child/special-note";
import DoseList from "./child/dose-list";
import SurveyResult from "./child/survey-result";
import PrescriptionList from "./child/prescription-list";
import HealthFoodList from "./child/health-food-list";

import MaleOutlinedIcon from "@mui/icons-material/MaleOutlined";
import FemaleOutlinedIcon from "@mui/icons-material/FemaleOutlined";
import { useMediaQuery } from "react-responsive";

function PatientInfo() {
  const { userInfo } = useLoaderData() as TPatientInfoLoaderReturn;

  const isMobile = useMediaQuery({ query: "(max-width: 480px)" });

  if (!userInfo) {
    return <PatientInfoText text="해당 환자에 대한 정보가 없습니다." />;
  }

  const { id, name, sex, birthday } = userInfo;

  return (
    <Outer>
      <Header>
        <BackButton to="/patient">
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
          {`${birthday.getFullYear()}.
          ${birthday.getMonth() + 1 < 10 ? "0".concat((birthday.getMonth() + 1).toString()) : birthday.getMonth() + 1}.
          ${birthday.getDate()}. `}
          {!isMobile && `(${getAge(birthday)}세)`}
        </Birthday>
      </PatientSummary>
      <NoteAndDoseList>
        <InnerBox>
          <SpecialNote patientId={id} />
        </InnerBox>
        <InnerBox>
          <DoseList patientId={id} />
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
