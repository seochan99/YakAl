import * as S from "../style.ts";
import Pagination from "react-js-pagination";
import { useMedicationViewController } from "./view.controller.ts";
import LoadingSpinner from "@/components/loading-spinner/view.tsx";
import { getDateStringFromArray } from "@util/get-date-string-from-array.ts";

function Medication() {
  const {
    isLoading,
    medication,
    paging: { onChangeETCPage, onChangeBeersListPage, onChangeAnticholinergicDrugsPage },
  } = useMedicationViewController();

  return (
    <S.OuterDiv>
      <S.ColumnDiv>
        <S.CardDiv>
          <S.HeaderDiv>
            <S.LeftTitleDiv>
              <S.TitleSpan>{"복용 중인 처방약"}</S.TitleSpan>
              <S.SubtitleSpan>{"Medications"}</S.SubtitleSpan>
            </S.LeftTitleDiv>
          </S.HeaderDiv>
          <S.MedicationETCContentDiv>
            {medication.etc.list !== null && medication.etc.total !== null ? (
              medication.etc.list.length === 0 ? (
                <S.CenterDiv>{"처방약에 대한 정보가 없습니다."}</S.CenterDiv>
              ) : (
                <>
                  <S.ListDiv>
                    {medication.etc.list.map((etcItem, index) => [
                      <S.RowDiv key={2 * index}>
                        <S.LeftTitleDiv>
                          <S.NormalSpan>{etcItem.name}</S.NormalSpan>
                        </S.LeftTitleDiv>
                        <S.RightTitleDiv>
                          <S.NormalSpan>{getDateStringFromArray(etcItem.prescribedAt)}</S.NormalSpan>
                        </S.RightTitleDiv>
                      </S.RowDiv>,
                      <S.Bar key={2 * index + 1} />,
                    ])}
                  </S.ListDiv>
                  <S.PaginationDiv>
                    <Pagination
                      activePage={medication.etc.page}
                      itemsCountPerPage={5}
                      totalItemsCount={medication.etc.total}
                      pageRangeDisplayed={5}
                      prevPageText={"‹"}
                      nextPageText={"›"}
                      onChange={onChangeETCPage}
                    />
                  </S.PaginationDiv>
                </>
              )
            ) : (
              <></>
            )}
          </S.MedicationETCContentDiv>
        </S.CardDiv>
        <S.CardDiv>
          <S.HeaderDiv>
            <S.LeftTitleDiv>
              <S.TitleSpan>{"Beers Criteria Medicine"}</S.TitleSpan>
            </S.LeftTitleDiv>
          </S.HeaderDiv>
          <S.MedicationETCContentDiv>
            {medication.beersCriteriaMedicines.list !== null && medication.beersCriteriaMedicines.total !== null ? (
              medication.beersCriteriaMedicines.list.length === 0 ? (
                <S.CenterDiv>{"처방약에 대한 정보가 없습니다."}</S.CenterDiv>
              ) : (
                <>
                  <S.ListDiv>
                    {medication.beersCriteriaMedicines.list.map((beersItem, index) => [
                      <S.RowDiv key={2 * index}>
                        <S.LeftTitleDiv>
                          <S.NormalSpan>{beersItem.name}</S.NormalSpan>
                        </S.LeftTitleDiv>
                        <S.RightTitleDiv>
                          <S.NormalSpan>{`${beersItem.prescribedAt[0]}. ${beersItem.prescribedAt[1] < 10 ? "0" : ""}${
                            beersItem.prescribedAt[1]
                          }. ${beersItem.prescribedAt[2] < 10 ? "0" : ""}${beersItem.prescribedAt[2]}.`}</S.NormalSpan>
                        </S.RightTitleDiv>
                      </S.RowDiv>,
                      <S.Bar key={2 * index + 1} />,
                    ])}
                  </S.ListDiv>
                  <S.PaginationDiv>
                    <Pagination
                      activePage={medication.beersCriteriaMedicines.page}
                      itemsCountPerPage={5}
                      totalItemsCount={medication.beersCriteriaMedicines.total}
                      pageRangeDisplayed={5}
                      prevPageText={"‹"}
                      nextPageText={"›"}
                      onChange={onChangeBeersListPage}
                    />
                  </S.PaginationDiv>
                </>
              )
            ) : (
              <></>
            )}
          </S.MedicationETCContentDiv>
        </S.CardDiv>
      </S.ColumnDiv>
      <S.ColumnDiv>
        {medication.armsProgress ? (
          <S.CardDiv>
            <S.HeaderDiv>
              <S.LeftTitleDiv>
                <S.TitleSpan>{"복약 순응도"}</S.TitleSpan>
                <S.SubtitleSpan>{"ARMS"}</S.SubtitleSpan>
              </S.LeftTitleDiv>
            </S.HeaderDiv>
            <S.MedicationGraphContentDiv>
              <S.CenterDiv>{"추후 제공될 예정입니다."}</S.CenterDiv>
              {/*<S.GraphDiv>*/}
              {/*  <ARMSGraph arms={medication.armsProgress} />*/}
              {/*</S.GraphDiv>*/}
            </S.MedicationGraphContentDiv>
          </S.CardDiv>
        ) : (
          <></>
        )}
        <S.CardDiv>
          <S.HeaderDiv>
            <S.LeftTitleDiv>
              <S.TitleSpan>{"항콜린성 약물"}</S.TitleSpan>
              <S.SubtitleSpan>{"Anticholinergic Drugs"}</S.SubtitleSpan>
            </S.LeftTitleDiv>
          </S.HeaderDiv>
          <S.MedicationETCContentDiv>
            {medication.anticholinergicDrugs.list !== null && medication.anticholinergicDrugs.total !== null ? (
              medication.anticholinergicDrugs.list.length === 0 ? (
                <S.CenterDiv>{"처방약에 대한 정보가 없습니다."}</S.CenterDiv>
              ) : (
                <>
                  <S.ListDiv>
                    {medication.anticholinergicDrugs.list.map((anticholinergicItem, index) => [
                      <S.AnticholinergicRowDiv key={2 * index}>
                        <S.LeftTitleDiv>
                          <S.NormalSpan>{anticholinergicItem.name}</S.NormalSpan>
                        </S.LeftTitleDiv>
                        <S.RightTitleDiv>
                          <S.NormalSpan>{`${anticholinergicItem.prescribedAt[0]}. ${
                            anticholinergicItem.prescribedAt[1] < 10 ? "0" : ""
                          }${anticholinergicItem.prescribedAt[1]}. ${
                            anticholinergicItem.prescribedAt[2] < 10 ? "0" : ""
                          }${anticholinergicItem.prescribedAt[2]}.`}</S.NormalSpan>
                          <S.RiskLevelDiv riskLevel={anticholinergicItem.riskLevel}>
                            {anticholinergicItem.riskLevel}
                          </S.RiskLevelDiv>
                        </S.RightTitleDiv>
                      </S.AnticholinergicRowDiv>,
                      <S.Bar key={2 * index + 1} />,
                    ])}
                  </S.ListDiv>
                  <S.PaginationDiv>
                    <Pagination
                      activePage={medication.anticholinergicDrugs.page}
                      itemsCountPerPage={5}
                      totalItemsCount={medication.anticholinergicDrugs.total}
                      pageRangeDisplayed={5}
                      prevPageText={"‹"}
                      nextPageText={"›"}
                      onChange={onChangeAnticholinergicDrugsPage}
                    />
                  </S.PaginationDiv>
                </>
              )
            ) : (
              <></>
            )}
          </S.MedicationETCContentDiv>
        </S.CardDiv>
        {isLoading && <LoadingSpinner />}
      </S.ColumnDiv>
    </S.OuterDiv>
  );
}

export default Medication;
