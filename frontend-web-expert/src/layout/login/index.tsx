import { Center, Outer } from "./style";
import Footer from "@/layout/footer";
import Header from "@/layout/header";
import { LOGIN_ROUTE } from "@/router/router";
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
