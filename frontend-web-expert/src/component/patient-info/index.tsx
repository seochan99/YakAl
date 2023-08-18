import { useLoaderData } from "react-router-dom";
import { Birthday, Hr, Subtitle, NameSex, Outer, PatientSummary, Sex, InnerBox } from "./style";

type TLoaderReturn = {
  patientId: number;
};

function PatientInfo() {
  const { patientId } = useLoaderData() as TLoaderReturn;

  return (
    <Outer>
      <PatientSummary>
        <NameSex>
          <Subtitle>김환자</Subtitle>
          <Sex>(여성)</Sex>
        </NameSex>
        <Birthday>2000. 01. 01. (24세)</Birthday>
      </PatientSummary>
      <Hr />
      <InnerBox>
        <Subtitle>특이 사항</Subtitle>
      </InnerBox>
      <Hr />
      <InnerBox>
        <Subtitle>복약 목록</Subtitle>
      </InnerBox>
      <Hr />
      <InnerBox>
        <Subtitle>자가 진단 테스트 결과</Subtitle>
      </InnerBox>
      <Hr />
      <InnerBox>
        <Subtitle>이전 처방 목록</Subtitle>
      </InnerBox>
      <Hr />
      <InnerBox>
        <Subtitle>복용 중인 건강기능식품</Subtitle>
      </InnerBox>
    </Outer>
  );
}

export default PatientInfo;
