import * as S from "../style.ts";
import { useGeriatricSyndromeViewController } from "@components/main/patient/child/geriatric-syndrome/view.controller.ts";

function GeriatricSyndrome() {
  const { geriatricSyndrome } = useGeriatricSyndromeViewController();

  const totalScore = {
    mna: geriatricSyndrome.mna?.length === 0 ? -1 : geriatricSyndrome.mna?.reduce((sum, current) => sum + current, 0),
    adl:
      geriatricSyndrome.mna?.length === 0
        ? -1
        : geriatricSyndrome.adl?.reduce(
            (sum, current, currentIndex) =>
              sum + (currentIndex === geriatricSyndrome.adl?.length ? (current ? 0 : 1) : current ? 1 : 0),
            0,
          ),
    delirium:
      geriatricSyndrome.mna?.length === 0
        ? -1
        : geriatricSyndrome.delirium?.reduce((sum, current) => sum + (current ? 1 : 0), 0),
    audioVisual: geriatricSyndrome.audiovisual,
  };

  const kaztADLQuestion = [
    "목욕",
    "옷 입고 벗기",
    "화장실 다녀오기",
    "이동",
    "식사",
    "요실금이나 변실금이 있으십니까?",
  ];

  const deliriumQuestion = [
    "입원 중에 본인이 어디에 있는지 모르거나 병원이 아닌 곳에 있다고 느낀 적이 있다.",
    "입원 중에 날짜가 몇일인지 혹은 무슨 요일인지 인지하는데 어려움이 많았다.",
    "입원 중에 가족이나 친한 지인이 누구인지 몰라봤던 적이 있었다.",
    "입원 중에 환각이나 환청을 경험한 적이 있었다.",
  ];

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
              {totalScore.adl ? (
                totalScore.adl === -1 ? (
                  <S.SubtitleSpan>{"설문 결과 없음"}</S.SubtitleSpan>
                ) : (
                  <>
                    <S.SubtitleSpan>
                      {totalScore.adl <= 4 && `치매 상담 요망`}
                      {5 <= totalScore.adl && `정상`}
                    </S.SubtitleSpan>
                    <S.NormalSpan>{`${totalScore.adl}점 / 6점`}</S.NormalSpan>
                  </>
                )
              ) : (
                <></>
              )}
            </S.RightTitleDiv>
          </S.HeaderDiv>
          <S.ContentDiv>
            {geriatricSyndrome.adl !== null ? (
              geriatricSyndrome.adl.length === 0 ? (
                <></>
              ) : (
                <>
                  {kaztADLQuestion.map((kaztADLItem, index) => {
                    const ele = [
                      <S.RowDiv key={2 * index}>
                        <S.LeftTitleDiv>
                          <S.NormalSpan>{kaztADLItem}</S.NormalSpan>
                        </S.LeftTitleDiv>
                        <S.RightTitleDiv>
                          <S.NormalSpan>{geriatricSyndrome.adl![index] ? "예" : "아니오"}</S.NormalSpan>
                        </S.RightTitleDiv>
                      </S.RowDiv>,
                    ];

                    if (index !== kaztADLQuestion.length - 1) {
                      ele.push(<S.Bar key={2 * index + 1} />);
                    }

                    return ele;
                  })}
                </>
              )
            ) : (
              <></>
            )}
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
            {totalScore.audioVisual !== null ? (
              <>
                <S.RowDiv>
                  <S.LeftTitleDiv>
                    <S.NormalSpan>{`안경 : ${
                      totalScore.audioVisual.useGlasses !== null
                        ? totalScore.audioVisual.useGlasses
                          ? "사용"
                          : "미사용"
                        : "설문 결과 없음"
                    }`}</S.NormalSpan>
                  </S.LeftTitleDiv>
                </S.RowDiv>
                <S.RowDiv>
                  <S.LeftTitleDiv>
                    <S.NormalSpan>{`보청기 : ${
                      totalScore.audioVisual.useHearingAid !== null
                        ? totalScore.audioVisual.useHearingAid
                          ? "사용"
                          : "미사용"
                        : "설문 결과 없음"
                    }`}</S.NormalSpan>
                  </S.LeftTitleDiv>
                </S.RowDiv>
              </>
            ) : (
              <></>
            )}
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
                <S.NormalSpan>
                  {geriatricSyndrome.fall !== null
                    ? geriatricSyndrome.fall.length === 0
                      ? "설문 결과 없음"
                      : `${geriatricSyndrome.fall.length}번 (${geriatricSyndrome.fall
                          .slice(0, 2)
                          .map(
                            (fallDate, index) =>
                              `${index !== 0 ? " " : ""}${fallDate[0]}/${fallDate[1] < 10 ? "0" : ""}${fallDate[1]}/${
                                fallDate[2] < 10 ? "0" : ""
                              }${fallDate[2]}`,
                          )}${geriatricSyndrome.fall.length > 2 ? ", ..." : ""})`
                    : "-"}
                </S.NormalSpan>
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
              {totalScore.mna ? (
                totalScore.mna === -1 ? (
                  <S.SubtitleSpan>{"설문 결과 없음"}</S.SubtitleSpan>
                ) : (
                  <>
                    <S.SubtitleSpan>
                      {0 <= totalScore.mna && totalScore.mna <= 7 && "영양 불량 상태"}
                      {8 <= totalScore.mna && totalScore.mna <= 11 && "영양 불량 위험 상태"}
                      {12 <= totalScore.mna && totalScore.mna <= 14 && "정상"}
                    </S.SubtitleSpan>
                    <S.NormalSpan>{`${totalScore.mna}점 / 14점`}</S.NormalSpan>
                  </>
                )
              ) : (
                "-"
              )}
            </S.RightTitleDiv>
          </S.HeaderDiv>
          <S.ContentDiv>
            {geriatricSyndrome.mna !== null ? (
              geriatricSyndrome.mna.length === 0 ? (
                <></>
              ) : (
                <>
                  <S.RowDiv>
                    <S.LeftTitleDiv>
                      <S.NormalSpan>
                        {
                          "지난 3개월 동안 밥맛이 없거나, 소화가 안되서나, 씹고 삼키는 것이 어려워서 식시랑이 줄었습니까?"
                        }
                      </S.NormalSpan>
                    </S.LeftTitleDiv>
                    <S.RightTitleDiv>
                      <S.NormalSpan>
                        {geriatricSyndrome.mna[0] === 0 && "그렇다"}
                        {geriatricSyndrome.mna[0] === 1 && "보통"}
                        {geriatricSyndrome.mna[0] === 2 && "아니다"}
                      </S.NormalSpan>
                    </S.RightTitleDiv>
                  </S.RowDiv>
                  <S.Bar />
                  <S.RowDiv>
                    <S.LeftTitleDiv>
                      <S.NormalSpan>{"지난 3개월 동안 몸무게가 줄었습니까?"}</S.NormalSpan>
                    </S.LeftTitleDiv>
                    <S.RightTitleDiv>
                      <S.NormalSpan>
                        {geriatricSyndrome.mna[1] === 0 && "3kg 이상 감소"}
                        {geriatricSyndrome.mna[1] === 2 && "1~2kg 감소"}
                        {geriatricSyndrome.mna[1] === 3 && "변화 없다"}
                        {geriatricSyndrome.mna[1] === 1 && "모르겠다"}
                      </S.NormalSpan>
                    </S.RightTitleDiv>
                  </S.RowDiv>
                  <S.Bar />
                  <S.RowDiv>
                    <S.LeftTitleDiv>
                      <S.NormalSpan>{"거동 능력"}</S.NormalSpan>
                    </S.LeftTitleDiv>
                    <S.RightTitleDiv>
                      <S.NormalSpan>
                        {geriatricSyndrome.mna[2] === 0 && "침대나 의자에서만 생활이 가능"}
                        {geriatricSyndrome.mna[2] === 1 && "집에서만 활동이 가능"}
                        {geriatricSyndrome.mna[2] === 2 && "외출 가능, 활동에 제약이 없음"}
                      </S.NormalSpan>
                    </S.RightTitleDiv>
                  </S.RowDiv>
                  <S.Bar />
                  <S.RowDiv>
                    <S.LeftTitleDiv>
                      <S.NormalSpan>
                        {"지난 3개월 동안 정신적 스트레스를 경험했거나, 급성 질환을 앓았던 적이 있습니까?"}
                      </S.NormalSpan>
                    </S.LeftTitleDiv>
                    <S.RightTitleDiv>
                      <S.NormalSpan>
                        {geriatricSyndrome.mna[3] === 0 && "예"}
                        {geriatricSyndrome.mna[3] === 2 && "아니오"}
                      </S.NormalSpan>
                    </S.RightTitleDiv>
                  </S.RowDiv>
                  <S.Bar />
                  <S.RowDiv>
                    <S.LeftTitleDiv>
                      <S.NormalSpan>{"신경정신과적 문제가 있습니까?"}</S.NormalSpan>
                    </S.LeftTitleDiv>
                    <S.RightTitleDiv>
                      <S.NormalSpan>
                        {geriatricSyndrome.mna[4] === 0 && "중증 치매 또는 우울증"}
                        {geriatricSyndrome.mna[4] === 1 && "경증 치매"}
                        {geriatricSyndrome.mna[4] === 2 && "없음"}
                      </S.NormalSpan>
                    </S.RightTitleDiv>
                  </S.RowDiv>
                  <S.Bar />
                  <S.RowDiv>
                    <S.LeftTitleDiv>
                      <S.NormalSpan>{"종아리 둘레"}</S.NormalSpan>
                    </S.LeftTitleDiv>
                    <S.RightTitleDiv>
                      <S.NormalSpan>
                        {geriatricSyndrome.mna[5] === 0 && "31cm보다 미만"}
                        {geriatricSyndrome.mna[5] === 3 && "31cm보다 이상"}
                      </S.NormalSpan>
                    </S.RightTitleDiv>
                  </S.RowDiv>
                </>
              )
            ) : (
              "-"
            )}
          </S.ContentDiv>
        </S.CardDiv>
        <S.CardDiv>
          <S.HeaderDiv>
            <S.LeftTitleDiv>
              <S.TitleSpan>{"섬망"}</S.TitleSpan>
              <S.SubtitleSpan>{"History of delirium"}</S.SubtitleSpan>
            </S.LeftTitleDiv>
            <S.RightTitleDiv>
              {totalScore.delirium ? (
                totalScore.delirium === -1 ? (
                  <S.SubtitleSpan>{"설문 결과 없음"}</S.SubtitleSpan>
                ) : (
                  <>
                    <S.SubtitleSpan>
                      {totalScore.delirium === 0 && "정상"}
                      {1 <= totalScore.delirium && "섬망 의심"}
                    </S.SubtitleSpan>
                    <S.NormalSpan>{`${totalScore.delirium}점 / 4점`}</S.NormalSpan>
                  </>
                )
              ) : (
                <></>
              )}
            </S.RightTitleDiv>
          </S.HeaderDiv>
          <S.ContentDiv>
            {geriatricSyndrome.delirium !== null ? (
              geriatricSyndrome.delirium.length === 0 ? (
                <></>
              ) : (
                <>
                  {deliriumQuestion.map((deliriumItem, index) => {
                    const ele = [
                      <S.RowDiv key={2 * index}>
                        <S.LeftTitleDiv>
                          <S.NormalSpan>{deliriumItem}</S.NormalSpan>
                        </S.LeftTitleDiv>
                        <S.RightTitleDiv>
                          <S.NormalSpan>{geriatricSyndrome.delirium![index] ? "예" : "아니오"}</S.NormalSpan>
                        </S.RightTitleDiv>
                      </S.RowDiv>,
                    ];

                    if (index !== deliriumQuestion.length - 1) {
                      ele.push(<S.Bar key={2 * index + 1} />);
                    }

                    return ele;
                  })}
                </>
              )
            ) : (
              <></>
            )}
          </S.ContentDiv>
        </S.CardDiv>
      </S.ColumnDiv>
    </S.OuterDiv>
  );
}

export default GeriatricSyndrome;
