import * as S from "./style.ts";
import ArrowDropDownIcon from "@mui/icons-material/ArrowDropDown";
import { useAdminFacilityListViewController } from "@components/admin-main/facility-list/view.controller.ts";
import Pagination from "react-js-pagination";
import { PatientListModel } from "@components/main/patient-list/model.ts";
import FacilityItem from "@components/admin-main/facility-item/view.tsx";
import { EFacilityField } from "@type/facility-field.ts";

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
            className={sortingOptionOpen ? "open" : ""}
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
          <S.RepresentativeSpan>{`기관장 이름`}</S.RepresentativeSpan>
          <S.TelephoneSpan>{`기관장 전화번호`}</S.TelephoneSpan>
          <S.RequestDateSpan>{`신청일`}</S.RequestDateSpan>
        </S.TableHeaderDiv>
        {facilityList.map((facilityItem) => (
          <FacilityItem key={facilityItem.id} facilityInfo={facilityItem} />
        ))}
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

export default AdminFacilityList;
