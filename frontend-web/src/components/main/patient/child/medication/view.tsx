import * as S from "../style.ts";
import Pagination from "react-js-pagination";
import ARMSGraph from "./arms-graph/view.tsx";
import { useMedicationViewController } from "./view.controller.ts";

function Medication() {
  const {
    medication,
    paging: { onChangeETCPage, onChangeBeersListPage, onChangeAnticholinergicDrugsPage },
  } = useMedicationViewController();

  return (
    <S.OuterDiv>
      <S.ColumnDiv>
        {medication.etc.list !== null && medication.etc.total !== null ? (
          <S.CardDiv>
            <S.HeaderDiv>
              <S.LeftTitleDiv>
                <S.TitleSpan>{"복용 중인 처방약"}</S.TitleSpan>
                <S.SubtitleSpan>{"Medications"}</S.SubtitleSpan>
              </S.LeftTitleDiv>
            </S.HeaderDiv>
            <S.ContentDiv>
              {medication.etc.list.map((etcItem, index) => [
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
                <S.Bar key={2 * index + 1} />,
              ])}
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
            </S.ContentDiv>
          </S.CardDiv>
        ) : (
          <></>
        )}
        {medication.beersCriteriaMedicines.list !== null && medication.beersCriteriaMedicines.total !== null ? (
          <S.CardDiv>
            <S.HeaderDiv>
              <S.LeftTitleDiv>
                <S.TitleSpan>{"Beers Criteria Medicine"}</S.TitleSpan>
              </S.LeftTitleDiv>
            </S.HeaderDiv>
            <S.ContentDiv>
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
            </S.ContentDiv>
          </S.CardDiv>
        ) : (
          <></>
        )}
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
            <S.ContentDiv>
              <S.GraphDiv>
                <ARMSGraph arms={medication.armsProgress} />
              </S.GraphDiv>
            </S.ContentDiv>
          </S.CardDiv>
        ) : (
          <></>
        )}
        {medication.anticholinergicDrugs.list && medication.anticholinergicDrugs.total ? (
          <S.CardDiv>
            <S.HeaderDiv>
              <S.LeftTitleDiv>
                <S.TitleSpan>{"항콜린성 약물"}</S.TitleSpan>
                <S.SubtitleSpan>{"Anticholinergic Drugs"}</S.SubtitleSpan>
              </S.LeftTitleDiv>
            </S.HeaderDiv>
            <S.ContentDiv>
              {medication.anticholinergicDrugs.list.map((anticholinergicItem, index) => [
                <S.RowDiv key={2 * index}>
                  <S.LeftTitleDiv>
                    <S.NormalSpan>{anticholinergicItem.name}</S.NormalSpan>
                  </S.LeftTitleDiv>
                  <S.RightTitleDiv>
                    <S.NormalSpan>{`${anticholinergicItem.prescribedAt[0]}. ${
                      anticholinergicItem.prescribedAt[1] < 10 ? "0" : ""
                    }${anticholinergicItem.prescribedAt[1]}. ${anticholinergicItem.prescribedAt[2] < 10 ? "0" : ""}${
                      anticholinergicItem.prescribedAt[2]
                    }.`}</S.NormalSpan>
                    <S.NormalSpan>{anticholinergicItem.riskLevel}</S.NormalSpan>
                  </S.RightTitleDiv>
                </S.RowDiv>,
                <S.Bar key={2 * index + 1} />,
              ])}
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
            </S.ContentDiv>
          </S.CardDiv>
        ) : (
          <></>
        )}
      </S.ColumnDiv>
    </S.OuterDiv>
  );
}

export default Medication;
