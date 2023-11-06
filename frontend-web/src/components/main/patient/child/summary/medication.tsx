import * as S from "../style.ts";
import { PatientPageViewModel } from "@components/main/patient/view.model.ts";
import { getDateStringFromArray } from "@util/get-date-string-from-array.ts";

function SummaryMedication() {
  const { getStates } = PatientPageViewModel;
  const {
    patientInfo: {
      medication: { etc },
    },
  } = getStates();

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
      <S.MedicationSummaryContentDiv>
        {etc.list === null || etc.total === null ? (
          <></>
        ) : etc.total === 0 ? (
          <S.CenterDiv>{"처방약에 대한 정보가 없습니다."}</S.CenterDiv>
        ) : (
          etc.list.map((etcItem, index) => {
            const ele = [
              <S.RowDiv key={2 * index}>
                <S.LeftTitleDiv>
                  <S.NormalSpan>{etcItem.name}</S.NormalSpan>
                </S.LeftTitleDiv>
                <S.RightTitleDiv>
                  <S.NormalSpan>{getDateStringFromArray(etcItem.prescribedAt)}</S.NormalSpan>
                </S.RightTitleDiv>
              </S.RowDiv>,
            ];

            if (index !== etc.total! - 1) {
              ele.push(<S.Bar key={2 * index + 1} />);
            }

            return ele;
          })
        )}
      </S.MedicationSummaryContentDiv>
    </S.CardDiv>
  );
}

export default SummaryMedication;
