import * as S from "./style.ts";
import Footer from "@layout/footer/view.tsx";
import Header from "@layout/header/view.tsx";
import { Outlet } from "react-router-dom";
import { useLoginPageViewController } from "@page/login/view.controller.ts";

export function LoginPage() {
  useLoginPageViewController();

  return (
    <S.OuterDiv>
      <Header to={"/"} />
      <S.CenteringMain>
        <Outlet />
      </S.CenteringMain>
      <Footer />
    </S.OuterDiv>
  );
}
