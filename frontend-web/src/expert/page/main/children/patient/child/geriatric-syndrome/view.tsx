import * as S from "../style.ts";

function GeriatricSyndrome() {
  const kaztADL = [
    { q: "목욕", a: false },
    { q: "옷 입고 벗기", a: false },
    { q: "화장실 다녀오기", a: false },
    { q: "이동", a: false },
    { q: "식사", a: false },
    { q: "요실금이나 변실금이 있으십니까?", a: true },
  ];
  const kaztADLTotal = 0;

  const mna = [
    {
      q: "지난 3개월 동안 밥맛이 없거나, 소화가 안되서나, 씹고 삼키는 것이 어려워서 식시랑이 줄었습니까?",
      a: 0,
      comment: "그렇다",
    },
    { q: "지난 3개월 동안 몸무게가 줄었습니까?", a: 0, comment: "3kg 이상 감소" },
    { q: "거동 능력", a: 1, comment: "집에서만 활동이 가능" },
    {
      q: "지난 3개월 동안 정신적 스트레스를 경험했거나, 급성 질환을 앓았던 적이 있습니까?",
      a: 0,
      comment: "예",
    },
    { q: "신경정신과적 문제가 있습니까?", a: 1, comment: "중증 치매 또는 우울증" },
    { q: "종아리 둘레", a: 3, comment: "31cm 보다 이상" },
  ];
  const mnaTotal = mna.reduce((sum, current) => sum + current.a, 0);

  const audioVisual = [
    { q: "안경을 쓰십니까?", a: true },
    { q: "보청기를 쓰십니까?", a: true },
  ];

  const delirium = [
    { q: "입원 중에 본인이 어디에 있는지 모르거나 병원이 아닌 곳에 있다고 느낀 적이 있다.", a: false },
    { q: "입원 중에 날짜가 몇일인지 혹은 무슨 요일인지 인지하는데 어려움이 많았다.", a: true },
    { q: "입원 중에 가족이나 친한 지인이 누구인지 몰라봤던 적이 있었다.", a: true },
    { q: "입원 중에 환각이나 환청을 경험한 적이 있었다.", a: false },
  ];
  const deliriumTotal = delirium.reduce((sum, current) => sum + (current.a ? 1 : 0), 0);

  return (
    <S.OuterDiv>
      <S.ColumnDiv>
        <S.CardDiv>
          <S.HeaderDiv>
            <S.LeftTitleDiv>
              <S.TitleSpan>{"일상생활 동작 지수"}</S.TitleSpan>
              <S.SubtitleSpan>{"KATZ ADL"}</S.SubtitleSpan>
            </S.LeftTitleDiv>
            <S.RightTitleDiv>
              <S.SubtitleSpan>
                {kaztADLTotal <= 4 && "치매 검사 요망"}
                {kaztADLTotal >= 5 && "정상"}
              </S.SubtitleSpan>
              <S.NormalSpan>{`${kaztADLTotal}점 / 6점`}</S.NormalSpan>
            </S.RightTitleDiv>
          </S.HeaderDiv>
          <S.ContentDiv>
            {kaztADL.map((kaztADLItem, index) => {
              const ele = [
                <S.RowDiv key={2 * index}>
                  <S.LeftTitleDiv>
                    <S.NormalSpan>{kaztADLItem.q}</S.NormalSpan>
                  </S.LeftTitleDiv>
                  <S.RightTitleDiv>
                    <S.NormalSpan>{kaztADLItem.a ? "예" : "아니오"}</S.NormalSpan>
                  </S.RightTitleDiv>
                </S.RowDiv>,
              ];

              if (index !== kaztADL.length - 1) {
                ele.push(<S.Bar key={2 * index + 1} />);
              }

              return ele;
            })}
          </S.ContentDiv>
        </S.CardDiv>
        <S.CardDiv>
          <S.HeaderDiv>
            <S.LeftTitleDiv>
              <S.TitleSpan>{"시청각 저하"}</S.TitleSpan>
              <S.SubtitleSpan>{"History of delirium"}</S.SubtitleSpan>
            </S.LeftTitleDiv>
          </S.HeaderDiv>
          <S.ContentDiv>
            <S.RowDiv>
              <S.LeftTitleDiv>
                <S.NormalSpan>{`안경 : ${audioVisual[0].a ? "사용" : "미사용"}`}</S.NormalSpan>
              </S.LeftTitleDiv>
            </S.RowDiv>
            <S.RowDiv>
              <S.LeftTitleDiv>
                <S.NormalSpan>{`보청기 : ${audioVisual[1].a ? "사용" : "미사용"}`}</S.NormalSpan>
              </S.LeftTitleDiv>
            </S.RowDiv>
          </S.ContentDiv>
        </S.CardDiv>
        <S.CardDiv>
          <S.HeaderDiv>
            <S.LeftTitleDiv>
              <S.TitleSpan>{"낙상"}</S.TitleSpan>
              <S.SubtitleSpan>{"Fall past 12 months"}</S.SubtitleSpan>
            </S.LeftTitleDiv>
          </S.HeaderDiv>
          <S.ContentDiv>
            <S.RowDiv>
              <S.LeftTitleDiv>
                <S.NormalSpan>{`2번 (7/11, 6/1)`}</S.NormalSpan>
              </S.LeftTitleDiv>
            </S.RowDiv>
          </S.ContentDiv>
        </S.CardDiv>
      </S.ColumnDiv>
      <S.ColumnDiv>
        <S.CardDiv>
          <S.HeaderDiv>
            <S.LeftTitleDiv>
              <S.TitleSpan>{"간이 영양 상태 조사"}</S.TitleSpan>
              <S.SubtitleSpan>{"MNA"}</S.SubtitleSpan>
            </S.LeftTitleDiv>
            <S.RightTitleDiv>
              <S.SubtitleSpan>
                {0 <= mnaTotal && mnaTotal <= 7 && "영양 불량 상태"}
                {8 <= mnaTotal && mnaTotal <= 11 && "영양 불량 위험 상태"}
                {12 <= mnaTotal && mnaTotal <= 14 && "정상"}
              </S.SubtitleSpan>
              <S.NormalSpan>{`${mnaTotal}점 / 14점`}</S.NormalSpan>
            </S.RightTitleDiv>
          </S.HeaderDiv>
          <S.ContentDiv>
            {mna.map((iADLItem, index) => {
              const ele = [
                <S.RowDiv key={2 * index}>
                  <S.LeftTitleDiv>
                    <S.NormalSpan>{iADLItem.q}</S.NormalSpan>
                  </S.LeftTitleDiv>
                  <S.RightTitleDiv>
                    <S.NormalSpan>{iADLItem.comment}</S.NormalSpan>
                  </S.RightTitleDiv>
                </S.RowDiv>,
              ];

              if (index !== mna.length - 1) {
                ele.push(<S.Bar key={2 * index + 1} />);
              }

              return ele;
            })}
          </S.ContentDiv>
        </S.CardDiv>
        <S.CardDiv>
          <S.HeaderDiv>
            <S.LeftTitleDiv>
              <S.TitleSpan>{"섬망"}</S.TitleSpan>
              <S.SubtitleSpan>{"History of delirium"}</S.SubtitleSpan>
            </S.LeftTitleDiv>
            <S.RightTitleDiv>
              <S.SubtitleSpan>
                {deliriumTotal === 0 && "정상"}
                {1 <= deliriumTotal && "섬망 의심"}
              </S.SubtitleSpan>
              <S.NormalSpan>{`${deliriumTotal}점 / 4점`}</S.NormalSpan>
            </S.RightTitleDiv>
          </S.HeaderDiv>
          <S.ContentDiv>
            {delirium.map((deliriumItem, index) => {
              const ele = [
                <S.RowDiv key={2 * index}>
                  <S.LeftTitleDiv>
                    <S.NormalSpan>{deliriumItem.q}</S.NormalSpan>
                  </S.LeftTitleDiv>
                  <S.RightTitleDiv>
                    <S.NormalSpan>{deliriumItem.a ? "예" : "아니오"}</S.NormalSpan>
                  </S.RightTitleDiv>
                </S.RowDiv>,
              ];

              if (index !== delirium.length - 1) {
                ele.push(<S.Bar key={2 * index + 1} />);
              }

              return ele;
            })}
          </S.ContentDiv>
        </S.CardDiv>
      </S.ColumnDiv>
    </S.OuterDiv>
  );
}

export default GeriatricSyndrome;
