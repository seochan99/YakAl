import { useEffect } from "react";
import { useNavigate } from "react-router-dom";

function SocialLogin() {
  const navigate = useNavigate();

  useEffect(() => {
    // const cookies = new Cookies();
    // const accessToken = cookies.get("accessToken");

    // logOnDev(`🔑 [Access Token Received] ${accessToken}`);

    // if (!accessToken) {
    //   navigate("/login/social/failure");
    //   return;
    // }

    // authAxios.defaults.headers.common["Authorization"] = `Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJ1aWQiOiI0Iiwicm9sIjoiUk9MRV9NT0JJTEUiLCJpYXQiOjE2OTg3Nzk5MTEsImV4cCI6MTY5ODc4MzUxMX0.GeEVkgMUzkdTwnEGkvsGygskpC-dz1O0ySmshezwbmVOqSog_zW0IKCwoRmwkTnKqADOEBLHi-Xtvapd3CDWmA`;

    navigate("/login/identify");
  }, [navigate]);

  return <></>;
}

export default SocialLogin;
