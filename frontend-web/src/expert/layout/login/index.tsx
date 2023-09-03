import { Center, Outer } from "./style.ts";
import Footer from "../footer";
import Header from "@/expert/layout/header";
import { EXPERT_LOGIN_ROUTE } from "@/global/router.tsx";
import { useMediaQuery } from "react-responsive";
import { Outlet } from "react-router-dom";

export function Login() {
  const isWideMobile = useMediaQuery({ query: "(max-width: 768px)" });

  return (
    <Outer>
      {!isWideMobile && <Header to={EXPERT_LOGIN_ROUTE} />}
      <Center>
        <Outlet />
      </Center>
      {!isWideMobile && <Footer />}
    </Outer>
  );
}
