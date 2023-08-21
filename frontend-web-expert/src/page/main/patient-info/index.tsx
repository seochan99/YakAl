import { useLoaderData } from "react-router-dom";
import {
  NameSex,
  Outer,
  PatientSummary,
  Sex,
  InnerBox,
  Name,
  Description,
  NoteAndDoseList,
  Header,
  BackButton,
  BackIcon,
} from "./style";
import { TPatientInfoLoaderReturn } from "./loader";
import { ESex } from "@/type/sex";
import getAge from "@/util/get-age";
import PatientInfoText from "./child/patient-info-text";
import SpecialNote from "./child/special-note";
import DoseList from "./child/dose-list";
import SurveyResult from "./child/test-result";

function PatientInfo() {
  const { userInfo } = useLoaderData() as TPatientInfoLoaderReturn;

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
          <Sex>{sex === ESex.MALE ? "(남성)" : "(여성)"}</Sex>
        </NameSex>
        <Description>
          {`${birthday.getFullYear()}.
          ${birthday.getMonth() + 1}.
          ${birthday.getDate()}.
          (${getAge(birthday)}세)`}
        </Description>
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
      <InnerBox>이전 처방 목록</InnerBox>
      <InnerBox>복용 중인 건강기능식품</InnerBox>
    </Outer>
  );
}

export default PatientInfo;
