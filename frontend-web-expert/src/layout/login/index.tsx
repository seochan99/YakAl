import { Center, Outer } from "./style";
import Footer from "@/layout/footer";
import Header from "@/layout/header";
import { LOGIN_ROUTE } from "@/router/router";
import { Outlet } from "react-router-dom";

function Login() {
  return (
    <Outer>
      <Header to={LOGIN_ROUTE} />
      <Center>
        <Outlet />
      </Center>
      <Footer />
    </Outer>
  );
}

export default Login;
