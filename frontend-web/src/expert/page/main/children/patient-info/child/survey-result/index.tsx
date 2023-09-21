import {
  Bar,
  Content,
  FirstList,
  Header,
  Item,
  ItemResult,
  ItemTitle,
  LinkButton,
  LinkIcon,
  List,
  Progress,
  Title,
} from "./style.ts";

export type TSurveyResultProps = {
  patientId: number;
};

function SurveyResult() {
  // const surveyKeyName = {
  //   medicationAdherence: "북약 순응도 체크리스트",
  //   depressionMeasure: "우울 척도 진단",
  //   decrepitude: "노쇠 설문",
  //   nutritionalStatus: "간이 영양 상태 조사",
  //   methodicalMovement: "수단적 일상생활 동작 평가",
  //   dailyMovement: "일상생활 동작 지수",
  //   screeningDepression: "우울증 선별 도구",
  //   drinkingHistory: "음주력",
  //   smokingHistory: "흡연력",
  //   audiovisualVision: "시청각",
  //   dementia: "치매",
  //   delirium: "섬망",
  //   insomnia: "불면증 심각도",
  //   sleepApnea: "폐쇄성 수면 무호흡증",
  // };

  return (
    <>
      <Header>
        <Title>자가 진단 테스트 결과</Title>
        <LinkButton>
          <LinkIcon />
        </LinkButton>
        <Progress>{`완료율 : ${Math.floor(80)}%`}</Progress>
      </Header>
      <Bar />
      <Content>
        <FirstList>
          <Item key={"치매"}>
            <ItemTitle>{"치매"}</ItemTitle>
            <ItemResult>{"치매"}</ItemResult>
          </Item>
        </FirstList>
        <List>
          <Item key={"섬망"}>
            <ItemTitle>{"섬망"}</ItemTitle>
            <ItemResult>{"섬망"}</ItemResult>
          </Item>
        </List>
      </Content>
    </>
  );
}

export default SurveyResult;
