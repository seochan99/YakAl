import { Detail, TopRight, Outer, MainSection } from "@/layout/main/style";
import { Outlet, useNavigation } from "react-router-dom";

import Footer from "@/layout/footer";
import Header from "../header";
import Profile from "@/layout/main/child/profile";
import NavBar from "@/component/navbar";
import { MAIN_DASHBOARD_ROUTE } from "@/router/router";

export default function Main() {
  const navigation = useNavigation();

  return (
    <Outer>
      <Header to={MAIN_DASHBOARD_ROUTE}>
        <TopRight>
          <NavBar />
          <Profile job="가정의학과 의사" name="홍길동" imgSrc="https://mui.com/static/images/avatar/1.jpg" />
        </TopRight>
      </Header>
      <MainSection>
        <Detail className={navigation.state === "loading" ? "loading" : ""}>
          <Outlet />
        </Detail>
      </MainSection>
      <Footer />
    </Outer>
  );
}
