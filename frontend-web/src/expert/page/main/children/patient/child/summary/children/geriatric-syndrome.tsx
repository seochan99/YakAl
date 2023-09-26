import * as S from "../../style.ts";
import { Bar } from "../../style.ts";

type TSummaryGeriatricSyndromeProps = {
  geriatricSyndrome: {
    mna: number[];
    adl: boolean[];
    delirium: boolean[];
    audiovisual: {
      useGlasses: boolean;
      useHearingAid: boolean;
    };
    fall: number[][];
  } | null;
};

function SummaryGeriatricSyndrome({ geriatricSyndrome }: TSummaryGeriatricSyndromeProps) {
  if (!geriatricSyndrome) {
    return <></>;
  }

  const totalScore = {
    mna: geriatricSyndrome.mna.reduce((sum, current) => sum + current, 0),
    adl: geriatricSyndrome.adl.reduce(
      (sum, current, currentIndex) =>
        sum + (currentIndex === geriatricSyndrome.adl.length ? (current ? 0 : 1) : current ? 1 : 0),
      0,
    ),
    delirium: geriatricSyndrome.delirium.reduce((sum, current) => sum + (current ? 1 : 0), 0),
    audioVisual: geriatricSyndrome.audiovisual,
    fall: geriatricSyndrome.fall.length,
  };

  return (
    <S.CardDiv>
      <S.HeaderDiv>
        <S.LeftTitleDiv>
          <S.TitleSpan>{"노화평가표"}</S.TitleSpan>
          <S.SubtitleSpan>{"Geriatric Syndrome"}</S.SubtitleSpan>
        </S.LeftTitleDiv>
      </S.HeaderDiv>
      <S.ContentDiv>
        <S.RowDiv>
          <S.LeftTitleDiv>
            <S.NormalSpan>{"Fall past 12 months (낙상사고)"}</S.NormalSpan>
          </S.LeftTitleDiv>
          <S.RightTitleDiv>
            <S.NormalSpan>{`${totalScore.fall}번`}</S.NormalSpan>
          </S.RightTitleDiv>
        </S.RowDiv>
        <Bar />
        <S.RowDiv>
          <S.LeftTitleDiv>
            <S.NormalSpan>{"History of delirium (섬망 경험 유무)"}</S.NormalSpan>
          </S.LeftTitleDiv>
          <S.RightTitleDiv>
            <S.NormalSpan>
              {1 <= totalScore.delirium && `섬망 의심`}
              {totalScore.delirium === 0 && `정상`}
            </S.NormalSpan>
          </S.RightTitleDiv>
        </S.RowDiv>
        <Bar />
        <S.RowDiv>
          <S.LeftTitleDiv>
            <S.NormalSpan>{"Sensory deticit (시청각 문제)"}</S.NormalSpan>
          </S.LeftTitleDiv>
          <S.RightTitleDiv>
            <S.NormalSpan>
              {`안경: ${totalScore.audioVisual.useGlasses ? "사용" : "미사용"}`}
              {` / `}
              {`보청기: ${totalScore.audioVisual.useHearingAid ? "사용" : "미사용"}`}
            </S.NormalSpan>
          </S.RightTitleDiv>
        </S.RowDiv>
        <Bar />
        <S.RowDiv>
          <S.LeftTitleDiv>
            <S.NormalSpan>{"KATZ ADL (일상생활 동작 지수)"}</S.NormalSpan>
          </S.LeftTitleDiv>
          <S.RightTitleDiv>
            <S.NormalSpan>
              {totalScore.adl <= 4 && `치매 상담 요망`}
              {5 <= totalScore.adl && `정상`}
            </S.NormalSpan>
          </S.RightTitleDiv>
        </S.RowDiv>
        <Bar />
        <S.RowDiv>
          <S.LeftTitleDiv>
            <S.NormalSpan>{"MNA (간이영양 상태조사)"}</S.NormalSpan>
          </S.LeftTitleDiv>
          <S.RightTitleDiv>
            <S.NormalSpan>
              {12 <= totalScore.mna && totalScore.mna <= 14 && `정상`}
              {8 <= totalScore.mna && totalScore.mna <= 11 && `영양불량 위험상태`}
              {totalScore.mna <= 7 && `영양 불량 상태`}
            </S.NormalSpan>
          </S.RightTitleDiv>
        </S.RowDiv>
      </S.ContentDiv>
    </S.CardDiv>
  );
}

export default SummaryGeriatricSyndrome;
