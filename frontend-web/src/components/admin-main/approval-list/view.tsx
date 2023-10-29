import * as S from "./style.ts";
import AdminExpertList from "@components/admin-main/expert-list/view.tsx";
import AdminFacilityList from "@components/admin-main/facility-list/view.tsx";
import { useAdminApprovalListViewController } from "@components/admin-main/approval-list/view.controller.ts";

function AdminApprovalList() {
  const { isExpert, onClickExpertList, onClickFacilityList } = useAdminApprovalListViewController();

  return (
    <S.ContentDiv>
      <S.TabBarDiv>
        <S.TabDiv className={isExpert ? "selected" : "unselected"} onClick={onClickExpertList}>
          <S.TabTitleSpan>전문가 리스트</S.TabTitleSpan>
          <S.TabSubtitleSpan>Doctor & Pharmacist List</S.TabSubtitleSpan>
        </S.TabDiv>
        <S.TabDiv className={isExpert ? "unselected" : "selected"} onClick={onClickFacilityList}>
          <S.TabTitleSpan>기관 리스트</S.TabTitleSpan>
          <S.TabSubtitleSpan>Medical Facility List</S.TabSubtitleSpan>
        </S.TabDiv>
      </S.TabBarDiv>
      <S.InnerDiv>{isExpert ? <AdminExpertList /> : <AdminFacilityList />}</S.InnerDiv>
    </S.ContentDiv>
  );
}

export default AdminApprovalList;
