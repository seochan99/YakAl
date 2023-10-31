import { useEffect } from "react";
import { useNavigate } from "react-router-dom";
import { Cookies } from "react-cookie";
import { logOnDev } from "@util/log-on-dev.ts";
import { authAxios } from "@api/auth/instance.ts";

function SocialLogin() {
  const navigate = useNavigate();

  useEffect(() => {
    const cookies = new Cookies();
    const accessToken = cookies.get("accessToken");

    logOnDev(`🔑 [Access Token Received] ${accessToken}`);

    if (!accessToken) {
      navigate("/login/social/failure");
      return;
    }

    authAxios.defaults.headers.common["Authorization"] = `Bearer ${accessToken}`;

    navigate("/login/identify");
  }, [navigate]);

  return <></>;
}

export default SocialLogin;
