import * as S from "../style.ts";
import SummaryGeriatricSyndrome from "./geriatric-syndrome.tsx";
import SummaryScreening from "./screening.tsx";
import SummaryMedication from "./medication.tsx";

function Summary() {
  return (
    <S.OuterDiv>
      <S.ColumnDiv>
        <SummaryMedication />
        <SummaryGeriatricSyndrome />
      </S.ColumnDiv>
      <S.ColumnDiv>
        <SummaryScreening />
      </S.ColumnDiv>
    </S.OuterDiv>
  );
}

export default Summary;
