import * as S from "../../style.ts";

type TSummaryScreeningProps = {
  screeningDetail: {
    arms: number[];
    gds: boolean[];
    phqNine: number[];
    frailty: boolean[];
    drinking: number[];
    dementia: number[];
    insomnia: number[];
    osa: boolean[];
    smoking: number[];
  } | null;
};

function SummaryScreening({ screeningDetail }: TSummaryScreeningProps) {
  if (!screeningDetail) {
    return <></>;
  }

  const totalScore = {
    arms: screeningDetail.arms.reduce((sum, current) => sum + current, 0),
    gds: screeningDetail.gds.reduce((sum, current, currentIndex) => {
      if (
        currentIndex === 1 ||
        currentIndex === 6 ||
        currentIndex === 7 ||
        currentIndex === 10 ||
        currentIndex === 11
      ) {
        return sum + (current ? 1 : 0);
      } else {
        return sum + (current ? 0 : 1);
      }
    }, 0),
    phqNine: screeningDetail.phqNine.reduce((sum, current) => sum + current, 0),
    frailty: screeningDetail.frailty.reduce((sum, current, currentIndex) => {
      if (currentIndex === 0 || currentIndex === 1 || currentIndex === 4) {
        return sum + (current ? 1 : 0);
      } else {
        return sum + (current ? 0 : 1);
      }
    }, 0),
    drinking: screeningDetail.drinking.reduce((sum, current) => sum + current, 0),
    dementia: screeningDetail.dementia.reduce((sum, current) => sum + (current === 0 ? 1 : 0), 0),
    insomnia: screeningDetail.insomnia.reduce((sum, current) => sum + current, 0),
    osa: screeningDetail.osa.reduce((sum, current) => sum + (current ? 1 : 0), 0),
    smoking: screeningDetail.smoking,
  };

  return (
    <S.CardDiv>
      <S.HeaderDiv>
        <S.LeftTitleDiv>
          <S.TitleSpan>{"설문조사"}</S.TitleSpan>
          <S.SubtitleSpan>{"Screening"}</S.SubtitleSpan>
        </S.LeftTitleDiv>
      </S.HeaderDiv>
      <S.ContentDiv>
        <S.RowDiv>
          <S.LeftTitleDiv>
            <S.NormalSpan>{"복약 순응도 테스트"}</S.NormalSpan>
          </S.LeftTitleDiv>
          <S.RightTitleDiv>
            <S.NormalSpan>{`${totalScore.arms}점 / 48점`}</S.NormalSpan>
          </S.RightTitleDiv>
        </S.RowDiv>
        <S.Bar />
        <S.RowDiv>
          <S.LeftTitleDiv>
            <S.NormalSpan>{"우울 척도 테스트 (GDS)"}</S.NormalSpan>
          </S.LeftTitleDiv>
          <S.RightTitleDiv>
            <S.NormalSpan>
              {totalScore.gds <= 5 && `정상 입니다`}
              {6 <= totalScore.gds && totalScore.gds <= 10 && `중간 정도의 우울 상태`}
              {11 <= totalScore.gds && totalScore.gds <= 15 && `중증도의 우울증 의심`}
            </S.NormalSpan>
          </S.RightTitleDiv>
        </S.RowDiv>
        <S.Bar />
        <S.RowDiv>
          <S.LeftTitleDiv>
            <S.NormalSpan>{"우울증 선별검사 (PHQ-9)"}</S.NormalSpan>
          </S.LeftTitleDiv>
          <S.RightTitleDiv>
            <S.NormalSpan>
              {totalScore.phqNine <= 4 && `우울 증상 없음`}
              {5 <= totalScore.phqNine && totalScore.phqNine <= 9 && `가벼운 우울증상`}
              {10 <= totalScore.phqNine && totalScore.phqNine <= 19 && `중간 정도의 우울증 의심`}
              {20 <= totalScore.phqNine && totalScore.phqNine <= 27 && `심한 우울증 의심`}
            </S.NormalSpan>
          </S.RightTitleDiv>
        </S.RowDiv>
        <S.Bar />
        <S.RowDiv>
          <S.LeftTitleDiv>
            <S.NormalSpan>{"노쇠 테스트 (Frailty)"}</S.NormalSpan>
          </S.LeftTitleDiv>
          <S.RightTitleDiv>
            <S.NormalSpan>
              {3 <= totalScore.frailty && `노쇠 의심`}
              {1 <= totalScore.frailty && totalScore.frailty <= 2 && `노쇠 전단계 의심`}
              {totalScore.frailty === 0 && `건강`}
            </S.NormalSpan>
          </S.RightTitleDiv>
        </S.RowDiv>
        <S.Bar />
        <S.RowDiv>
          <S.LeftTitleDiv>
            <S.NormalSpan>{"음주력 테스트"}</S.NormalSpan>
          </S.LeftTitleDiv>
          <S.RightTitleDiv>
            <S.NormalSpan>
              {totalScore.drinking <= 9 && `위험 수준 아님`}
              {10 <= totalScore.drinking && totalScore.drinking <= 15 && `습관적 과음 주의`}
              {16 <= totalScore.drinking && totalScore.drinking <= 19 && `해로운 수준(남용)`}
              {20 <= totalScore.drinking && totalScore.drinking <= 40 && `매우 위험한 수준`}
            </S.NormalSpan>
          </S.RightTitleDiv>
        </S.RowDiv>
        <S.Bar />
        <S.RowDiv>
          <S.LeftTitleDiv>
            <S.NormalSpan>{"흡연력 테스트"}</S.NormalSpan>
          </S.LeftTitleDiv>
          <S.RightTitleDiv>
            <S.NormalSpan>
              {totalScore.smoking[0] === 0 && `흡연 경력 없음`}
              {totalScore.smoking[0] !== 0 &&
                `흡연 경력: ${totalScore.smoking[1]}년 / 하루 흡연량: ${
                  totalScore.smoking[2] === 0
                    ? "1/2갑 미만"
                    : totalScore.smoking[2] === 1
                    ? "1/2갑~1갑"
                    : totalScore.smoking[2] === 2
                    ? "1갑~2갑"
                    : "2갑 이상"
                }`}
            </S.NormalSpan>
          </S.RightTitleDiv>
        </S.RowDiv>
        <S.Bar />
        <S.RowDiv>
          <S.LeftTitleDiv>
            <S.NormalSpan>{"불면증 심각도"}</S.NormalSpan>
          </S.LeftTitleDiv>
          <S.RightTitleDiv>
            <S.NormalSpan>
              {0 <= totalScore.insomnia && totalScore.insomnia <= 7 && `정상`}
              {8 <= totalScore.insomnia && totalScore.insomnia <= 14 && `약간의 불면증`}
              {15 <= totalScore.insomnia && totalScore.insomnia <= 21 && `중증도의 불면증`}
              {22 <= totalScore.insomnia && totalScore.insomnia <= 28 && `심한 불면증`}
            </S.NormalSpan>
          </S.RightTitleDiv>
        </S.RowDiv>
        <S.Bar />
        <S.RowDiv>
          <S.LeftTitleDiv>
            <S.NormalSpan>{"치매 테스트"}</S.NormalSpan>
          </S.LeftTitleDiv>
          <S.RightTitleDiv>
            <S.NormalSpan>
              {2 <= totalScore.dementia && `인지 기능의 변화가 의심됨`}
              {totalScore.dementia <= 1 && `정상`}
            </S.NormalSpan>
          </S.RightTitleDiv>
        </S.RowDiv>
        <S.Bar />
        <S.RowDiv>
          <S.LeftTitleDiv>
            <S.NormalSpan>{"폐쇄성 수면 무호흡증"}</S.NormalSpan>
          </S.LeftTitleDiv>
          <S.RightTitleDiv>
            <S.NormalSpan>
              {totalScore.osa <= 2 && `정상`}
              {3 <= totalScore.osa && totalScore.osa <= 4 && `약간의 불면증`}
              {5 <= totalScore.osa && `중증도의 불면증`}
            </S.NormalSpan>
          </S.RightTitleDiv>
        </S.RowDiv>
      </S.ContentDiv>
    </S.CardDiv>
  );
}

export default SummaryScreening;
