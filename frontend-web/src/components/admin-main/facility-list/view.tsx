import * as S from "./style.ts";
import ArrowDropDownIcon from "@mui/icons-material/ArrowDropDown";
import { useAdminFacilityListViewController } from "@components/admin-main/facility-list/view.controller.ts";
import Pagination from "react-js-pagination";
import FacilityItem from "@components/admin-main/facility-item/view.tsx";
import { EFacilityField } from "@type/facility-field.ts";
import { AdminFacilityListModel } from "@store/admin-facility-list.ts";
import { EOrder } from "@type/order.ts";

function AdminFacilityList() {
  const {
    selectListRef,
    onChangePage,
    searching: { nameQueryCache, setNameQueryCache, onSearchBarEnter },
    sorting: { onSelectSortingOption, sortingOptionOpen, setSortingOptionOpen },
    data: { isLoading, facilityList, paging, sorting },
  } = useAdminFacilityListViewController();

  if (isLoading || facilityList === null) {
    return <></>;
  }

  return (
    <>
      <S.OptionBarDiv>
        <S.SearchBarDiv>
          <S.StyledSearchIconSvg />
          <S.SearchInput
            type="text"
            placeholder="기관 이름으로 검색"
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
              {Object.keys(EFacilityField).map((facilityFilter) => {
                const value = EFacilityField[facilityFilter as keyof typeof EFacilityField];
                return (
                  <S.SelectItem key={facilityFilter}>
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
          <S.NameSpan>{`기관명`}</S.NameSpan>
          <S.FacilityTypeSpan>{`기관 종류`}</S.FacilityTypeSpan>
          <S.RepresentativeSpan>{`기관장명`}</S.RepresentativeSpan>
          <S.TelephoneSpan>{`기관장 전화번호`}</S.TelephoneSpan>
          <S.RequestDateSpan>{`신청일`}</S.RequestDateSpan>
        </S.TableHeaderDiv>
        {facilityList.length === 0 ? (
          <S.CenterDiv>{"등록 신청한 기관이 존재하지 않습니다."}</S.CenterDiv>
        ) : (
          facilityList.map((facilityItem) => <FacilityItem key={facilityItem.id} facilityInfo={facilityItem} />)
        )}
      </S.ListDiv>
      <S.PaginationDiv>
        <Pagination
          activePage={paging.pageNumber}
          itemsCountPerPage={AdminFacilityListModel.FACILITY_COUNT_PER_PAGE}
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

export default AdminFacilityList;
