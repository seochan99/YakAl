import * as S from "../style.ts";
import SummaryGeriatricSyndrome from "./children/geriatric-syndrome.tsx";
import SummaryScreening from "./children/screening.tsx";
import SummaryMedication from "./children/medication.tsx";

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
