import * as S from "./style.ts";
import Footer from "@layout/footer/view.tsx";
import Header from "@layout/header/view.tsx";
import { Outlet } from "react-router-dom";
import { useLoginPageViewController } from "@page/login/view.controller.ts";
import LoadingSpinner from "@/components/loading-spinner/view.tsx";

export function LoginPage() {
  const { isLoading } = useLoginPageViewController();

  return (
    <S.OuterDiv>
      <Header to={"/"} />
      <S.CenteringMain>
        <Outlet />
      </S.CenteringMain>
      <Footer />
      {isLoading && <LoadingSpinner />}
    </S.OuterDiv>
  );
}
