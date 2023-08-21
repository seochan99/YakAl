import {
  Bar,
  Content,
  FirstList,
  Item,
  LinkButton,
  LinkIcon,
  List,
  ItemTitle,
  Title,
  ItemResult,
  Progress,
} from "./style";

function SurveyResult() {
  const surveyResult = {
    medicationAdherence: 0, // 북약 순응도 체크리스트
    depressionMeasure: 1, // 우울 척도 진단
    decrepitude: 1, // 노쇠 설문
    nutritionalStatus: 2, // 간이 영양 상태 조사
    methodicalMovement: 0, // 수단적 일상생활 동작 평가
    dailyMovement: 1, // 일상생활 동작 지수
    screeningDepression: 2, // 우울증 선별 도구
    drinkingHistory: 3, // 음주력
    smokingHistory: 100, // 흡연력
    audiovisualVision: 0, // 시청각
    dementia: 2, // 치매
    delirium: 1, // 섬망
    insomnia: 0, // 불면증 심각도
    sleepApnea: 30, // 폐쇄성 수면 무호흡증
  };

  const surveyKeyName = {
    medicationAdherence: "북약 순응도 체크리스트",
    depressionMeasure: "우울 척도 진단",
    decrepitude: "노쇠 설문",
    nutritionalStatus: "간이 영양 상태 조사",
    methodicalMovement: "수단적 일상생활 동작 평가",
    dailyMovement: "일상생활 동작 지수",
    screeningDepression: "우울증 선별 도구",
    drinkingHistory: "음주력",
    smokingHistory: "흡연력",
    audiovisualVision: "시청각",
    dementia: "치매",
    delirium: "섬망",
    insomnia: "불면증 심각도",
    sleepApnea: "폐쇄성 수면 무호흡증",
  };

  const surveyResultKeyList = Object.keys(surveyResult);
  const surveyCount = surveyResultKeyList.length;

  return (
    <>
      <Title>
        자가 진단 테스트 결과
        <LinkButton>
          <LinkIcon />
        </LinkButton>
        <Progress>
          {`완료율 : ${
            Math.floor(100 * Object.values(surveyResult).filter((result) => result !== null).length) /
            Object.values(surveyResult).length
          }%`}
        </Progress>
      </Title>
      <Bar />
      <Content>
        <FirstList>
          {surveyResultKeyList.slice(0, surveyCount / 2).map((surveyKey) => (
            <Item key={surveyKey}>
              <ItemTitle>{surveyKeyName[surveyKey as keyof typeof surveyKeyName]}</ItemTitle>
              <ItemResult>{surveyResult[surveyKey as keyof typeof surveyResult]}</ItemResult>
            </Item>
          ))}
        </FirstList>
        <List>
          {surveyResultKeyList.slice(surveyCount / 2, surveyCount).map((surveyKey) => (
            <Item key={surveyKey}>
              <ItemTitle>{surveyKeyName[surveyKey as keyof typeof surveyKeyName]}</ItemTitle>
              <ItemResult>{surveyResult[surveyKey as keyof typeof surveyResult]}</ItemResult>
            </Item>
          ))}
        </List>
      </Content>
    </>
  );
}

export default SurveyResult;
