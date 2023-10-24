import * as S from "./style.ts";
import Header from "@layout/header/view.tsx";
import { Outlet } from "react-router-dom";
import Footer from "../../layout/footer/view.tsx";

function AdminLogin() {
  return (
    <S.OuterDiv>
      <Header to={"/expert/login"} />
      <S.CenteringMain>
        <Outlet />
      </S.CenteringMain>
      <Footer />
    </S.OuterDiv>
  );
}

export default AdminLogin;
