import * as S from "./style.ts";
import { useAdminMainViewController } from "@page/admin-main/view.controller.ts";
import Header from "@layout/header/view.tsx";
import Footer from "@layout/footer/view.tsx";
import AdminExpertList from "@components/admin-main/expert-list/view.tsx";
import AdminFacilityList from "@components/admin-main/facility-list/view.tsx";

function AdminMain() {
  const { isExpert, onClickExpertList, onClickFacilityList } = useAdminMainViewController();

  return (
    <S.OuterDiv>
      <Header to={"/admin/main"} isAdmin={true} />
      <S.CenteringMain>
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
      </S.CenteringMain>
      <Footer />
    </S.OuterDiv>
  );
}

export default AdminMain;
