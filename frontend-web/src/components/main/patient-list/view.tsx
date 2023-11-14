import * as S from "./style.ts";
import { usePatientListPageViewController } from "./view.controller.ts";
import { EPatientField } from "@type/enum/patient-field.ts";
import Pagination from "react-js-pagination";

import ArrowDropDownIcon from "@mui/icons-material/ArrowDropDown";
import PatientItem from "@components/main/patient-list/patient-item/view.tsx";
import { PatientListModel } from "@store/patient-list.ts";
import { EOrder } from "@type/enum/order.ts";
import LoadingSpinner from "@components/loading-spinner/view.tsx";

function PatientListPage() {
  const {
    selectListRef,
    onChangePage,
    managed: { isOnlyManaged, onSelectMangedList, onSelectEntireList, onClickToManageFactory },
    searching: { nameQuery, nameQueryCache, setNameQueryCache, onSearchBarEnter },
    sorting: { onSelectSortingOption, sortingOptionOpen, setSortingOptionOpen },
    data: { isLoading, patientList, paging, sorting, isEmpty },
  } = usePatientListPageViewController();

  if (isLoading) {
    return (
      <S.OuterDiv>
        <LoadingSpinner />
      </S.OuterDiv>
    );
  }

  // if (!isExpert) {
  //   return (
  //     <S.OuterDiv>
  //       <S.IsNotExpertSpan>{"전문가 인증이 필요한 기능입니다."}</S.IsNotExpertSpan>
  //     </S.OuterDiv>
  //   );
  // }

  return (
    <S.OuterDiv>
      <S.TabBarDiv>
        <S.TabDiv className={isOnlyManaged ? "selected" : "unselected"} onClick={onSelectMangedList}>
          <S.TabTitleSpan>관리 환자 리스트</S.TabTitleSpan>
          <S.TabSubtitleSpan>Managed Patient List</S.TabSubtitleSpan>
        </S.TabDiv>
        <S.TabDiv className={isOnlyManaged ? "unselected" : "selected"} onClick={onSelectEntireList}>
          <S.TabTitleSpan>전체 환자 리스트</S.TabTitleSpan>
          <S.TabSubtitleSpan>Entire Patient List</S.TabSubtitleSpan>
        </S.TabDiv>
      </S.TabBarDiv>
      <S.InnerDiv>
        <S.OptionBarDiv>
          <S.SearchBarDiv>
            <S.StyledSearchIconSvg />
            <S.SearchInput
              type="text"
              placeholder="환자 이름으로 검색"
              value={nameQueryCache}
              onChange={(e) => setNameQueryCache(e.target.value)}
              onKeyUp={onSearchBarEnter}
            />
          </S.SearchBarDiv>
          <S.SelectDiv data-role="selectbox">
            <S.SelectButton
              className={sorting.order === EOrder.ASC ? "asc" : ""}
              onClick={() => setSortingOptionOpen(!sortingOptionOpen)}
            >
              <ArrowDropDownIcon />
              <span>{sorting.field}</span>
            </S.SelectButton>
            {sortingOptionOpen && (
              <S.SelectList ref={selectListRef}>
                {Object.keys(EPatientField).map((patientFilter) => {
                  const value = EPatientField[patientFilter as keyof typeof EPatientField];
                  return (
                    <S.SelectItem key={patientFilter}>
                      <S.SelectItemButton value={value} onClick={onSelectSortingOption}>
                        {value}
                      </S.SelectItemButton>
                    </S.SelectItem>
                  );
                })}
              </S.SelectList>
            )}
          </S.SelectDiv>
        </S.OptionBarDiv>
        <S.ListDiv>
          <S.TableHeaderDiv>
            <S.NameSpan>{`이름`}</S.NameSpan>
            <S.SexBirthdaySpan>{`생년월일`}</S.SexBirthdaySpan>
            <S.TelephoneSpan>{`전화번호`}</S.TelephoneSpan>
            <S.LastQuestionnaireDateSpan>{`최근 설문일`}</S.LastQuestionnaireDateSpan>
          </S.TableHeaderDiv>
          {isEmpty ? (
            <S.CenterDiv>
              <S.NotFoundSpan>
                {nameQuery.length === 0
                  ? isOnlyManaged
                    ? "관심 환자가 존재하지 않습니다."
                    : "설문을 보낸 환자가 없습니다."
                  : "검색 결과가 없습니다."}
              </S.NotFoundSpan>
            </S.CenterDiv>
          ) : (
            patientList!.map((patientItem) => (
              <PatientItem
                key={patientItem.id}
                patientInfo={patientItem}
                onClickToManage={onClickToManageFactory(patientItem.id)}
                onClickToNotManage={onClickToManageFactory(patientItem.id)}
              />
            ))
          )}
        </S.ListDiv>
        <S.PaginationDiv>
          <Pagination
            activePage={paging.pageNumber}
            itemsCountPerPage={PatientListModel.PATIENT_COUNT_PER_PAGE}
            totalItemsCount={paging.totalCount as number}
            pageRangeDisplayed={5}
            prevPageText={"‹"}
            nextPageText={"›"}
            onChange={onChangePage}
          />
        </S.PaginationDiv>
      </S.InnerDiv>
    </S.OuterDiv>
  );
}

export default PatientListPage;
