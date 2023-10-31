import * as S from "./style.ts";
import Footer from "../../layout/footer/view.tsx";
import Header from "../../layout/header/view.tsx";
import { useMediaQuery } from "react-responsive";
import { Outlet } from "react-router-dom";

export function LoginPage() {
  const isWideMobile = useMediaQuery({ query: "(max-width: 768px)" });

  if (isWideMobile) {
    return (
      <S.CenteringOuterDiv>
        <Outlet />
      </S.CenteringOuterDiv>
    );
  }

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
