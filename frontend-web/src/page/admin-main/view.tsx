import * as S from "./style.ts";
import Header from "@layout/header/view.tsx";
import Footer from "@layout/footer/view.tsx";
import { Outlet } from "react-router-dom";

function AdminMain() {
  return (
    <S.OuterDiv>
      <Header to={"/admin/main"} isAdmin={true} />
      <S.CenteringMain>
        <Outlet />
      </S.CenteringMain>
      <Footer />
    </S.OuterDiv>
  );
}

export default AdminMain;
