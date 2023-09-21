import * as S from "./style.ts";
import Footer from "../footer";
import Header from "../../../expert/layout/header";
import { useMediaQuery } from "react-responsive";
import { Outlet } from "react-router-dom";

export function Login() {
  const isWideMobile = useMediaQuery({ query: "(max-width: 768px)" });

  if (isWideMobile) {
    return (
      <S.CenteringOuterDiv>
        <Outlet />
      </S.CenteringOuterDiv>
    );
  }

  return (
    <S.Outer>
      <Header to={"/expert/login"} />
      <S.Center>
        <Outlet />
      </S.Center>
      <Footer />
    </S.Outer>
  );
}
