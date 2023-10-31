import * as S from "../../style.ts";

type TSummaryMedicationProps = {
  etcList:
    | {
        name: string;
        prescribedAt: number[];
      }[]
    | null;
};

function SummaryMedication({ etcList }: TSummaryMedicationProps) {
  if (etcList === null) {
    return <></>;
  }

  return (
    <S.CardDiv>
      <S.HeaderDiv>
        <S.LeftTitleDiv>
          <S.TitleSpan>{"복용 중인 처방약"}</S.TitleSpan>
          <S.SubtitleSpan>{"Medications"}</S.SubtitleSpan>
        </S.LeftTitleDiv>
        <S.RightTitleDiv>
          <S.SubtitleSpan>{"Last 5 items"}</S.SubtitleSpan>
        </S.RightTitleDiv>
      </S.HeaderDiv>
      <S.ContentDiv>
        {etcList.map((etcItem, index) => {
          const ele = [
            <S.RowDiv key={2 * index}>
              <S.LeftTitleDiv>
                <S.NormalSpan>{etcItem.name}</S.NormalSpan>
              </S.LeftTitleDiv>
              <S.RightTitleDiv>
                <S.NormalSpan>{`${etcItem.prescribedAt[0]}. ${etcItem.prescribedAt[1] < 10 ? "0" : ""}${
                  etcItem.prescribedAt[1]
                }. ${etcItem.prescribedAt[2] < 10 ? "0" : ""}${etcItem.prescribedAt[2]}.`}</S.NormalSpan>
              </S.RightTitleDiv>
            </S.RowDiv>,
          ];

          if (index !== etcList.length - 1) {
            ele.push(<S.Bar key={2 * index + 1} />);
          }

          return ele;
        })}
      </S.ContentDiv>
    </S.CardDiv>
  );
}

export default SummaryMedication;
