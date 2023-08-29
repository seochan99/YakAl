import { Center, Outer } from "./style.ts";
import Footer from "@/expert/layout/footer";
import Header from "@/expert/layout/header";
import { LOGIN_ROUTE } from "@/expert/router/router.tsx";
import { useMediaQuery } from "react-responsive";
import { Outlet } from "react-router-dom";

function Login() {
  const isWideMobile = useMediaQuery({ query: "(max-width: 768px)" });

  return (
    <Outer>
      {!isWideMobile && <Header to={LOGIN_ROUTE} />}
      <Center>
        <Outlet />
      </Center>
      {!isWideMobile && <Footer />}
    </Outer>
  );
}

export default Login;
