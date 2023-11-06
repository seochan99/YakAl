import { useAdminExpertListViewController } from "@components/admin-main/expert-list/view.controller.ts";
import * as S from "./style.ts";
import ArrowDropDownIcon from "@mui/icons-material/ArrowDropDown";
import Pagination from "react-js-pagination";
import { PatientListModel } from "@store/patient-list.ts";
import AdminExpertItem from "@components/admin-main/expert-item/view.tsx";
import { EExpertField } from "@type/expert-field.ts";
import { EOrder } from "@type/order.ts";

function AdminExpertList() {
  const {
    selectListRef,
    onChangePage,
    searching: { nameQueryCache, setNameQueryCache, onSearchBarEnter },
    sorting: { onSelectSortingOption, sortingOptionOpen, setSortingOptionOpen },
    data: { isLoading, expertList, paging, sorting },
  } = useAdminExpertListViewController();

  if (isLoading || expertList === null) {
    return <></>;
  }

  return (
    <>
      <S.OptionBarDiv>
        <S.SearchBarDiv>
          <S.StyledSearchIconSvg />
          <S.SearchInput
            type="text"
            placeholder="전문가 이름으로 검색"
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
              {Object.keys(EExpertField).map((expertFilter) => {
                const value = EExpertField[expertFilter as keyof typeof EExpertField];
                return (
                  <S.SelectItem key={expertFilter}>
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
          <S.JobTypeSpan>{`직종`}</S.JobTypeSpan>
          <S.FacilityNameSpan>{`소속기관명`}</S.FacilityNameSpan>
          <S.TelephoneSpan>{`전화번호`}</S.TelephoneSpan>
          <S.RequestDateSpan>{`신청일`}</S.RequestDateSpan>
        </S.TableHeaderDiv>
        {expertList.length === 0 ? (
          <S.CenterDiv>{"등록 신청한 전문가가 존재하지 않습니다."}</S.CenterDiv>
        ) : (
          expertList.map((expertItem) => <AdminExpertItem key={expertItem.id} expertInfo={expertItem} />)
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
    </>
  );
}

export default AdminExpertList;
