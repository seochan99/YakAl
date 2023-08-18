import { Detail, TopRight, Outer, MainSection } from "@/layout/main/style";
import { Outlet, useNavigation } from "react-router-dom";

import Footer from "@/layout/footer";
import Header from "../header";
import Profile from "@/component/profile";
import IconBox from "@/component/icon-box";
import Sidebar from "../sidebar";
import { MAIN_DASHBOARD_ROUTE } from "@/router/router";
import { useEffect } from "react";

export default function Main() {
  const navigation = useNavigation();

  useEffect(() => {
    console.log(document.cookie);
  }, []);

  return (
    <Outer>
      <Header to={MAIN_DASHBOARD_ROUTE}>
        <TopRight>
          <IconBox />
          <Profile
            job="가정의학과 의사"
            name="박하늘별님구름햇님보다사랑스러우리"
            imgSrc="https://mui.com/static/images/avatar/1.jpg"
          />
        </TopRight>
      </Header>
      <MainSection>
        <Sidebar />
        <Detail className={navigation.state === "loading" ? "loading" : ""}>
          <Outlet />
        </Detail>
      </MainSection>
      <Footer />
    </Outer>
  );
}
