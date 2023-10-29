import * as S from "../style.ts";
import { useSummaryViewController } from "./view.controller.ts";
import SummaryGeriatricSyndrome from "./children/geriatric-syndrome.tsx";
import SummaryScreening from "./children/screening.tsx";
import SummaryMedication from "./children/medication.tsx";

function Summary() {
  const { medication, geriatricSyndrome, screeningDetail } = useSummaryViewController();

  return (
    <S.OuterDiv>
      <S.ColumnDiv>
        <SummaryMedication etcList={medication.etc.list} />
        <SummaryGeriatricSyndrome geriatricSyndrome={geriatricSyndrome} />
      </S.ColumnDiv>
      <S.ColumnDiv>
        <SummaryScreening screeningDetail={screeningDetail} />
      </S.ColumnDiv>
    </S.OuterDiv>
  );
}

export default Summary;
