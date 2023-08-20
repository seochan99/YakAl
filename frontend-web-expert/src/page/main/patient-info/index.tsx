import { useLoaderData } from "react-router-dom";
import {
  Hr,
  Subtitle,
  NameSex,
  Outer,
  PatientSummary,
  Sex,
  InnerBox,
  SpecialNoteList,
  Name,
  Description,
  SpecialNoteItem,
  Content,
  RecordedDate,
} from "./style";
import { TPatientInfoLoaderReturn } from "./loader";
import { ESex } from "@/type/sex";
import getAge from "@/util/get-age";
import PatientInfoText from "./child/patient-info-text";

function PatientInfo() {
  const { userInfo } = useLoaderData() as TPatientInfoLoaderReturn;

  if (!userInfo) {
    return <PatientInfoText text="해당 환자에 대한 정보가 없습니다." />;
  }

  const { name, sex, birthday } = userInfo;

  const items = () => {
    const ele = [];

    for (let i = 0; i < 3; ++i) {
      ele.push(
        <SpecialNoteItem>
          <Content>안녕하세요안녕하세요안녕하세요안녕하세요안녕하세요안녕...</Content>
          <RecordedDate>기록일: 2023. 08. 20.</RecordedDate>
        </SpecialNoteItem>, // 이 박스를 하나의 컴포넌트로 빼는 게 좋겠다!!
      );
    }

    return ele;
  };

  return (
    <Outer>
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
      <Hr />
      <InnerBox>
        <Subtitle>특이 사항</Subtitle>
        <SpecialNoteList>{items()}</SpecialNoteList>
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
