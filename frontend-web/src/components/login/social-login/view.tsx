import { useEffect } from "react";
import { Cookies } from "react-cookie";
import { useNavigate } from "react-router-dom";
import { authAxios } from "../../../api/auth/instance.ts";

function SocialLogin() {
  const navigate = useNavigate();

  useEffect(() => {
    const cookies = new Cookies();
    const accessToken = cookies.get("accessToken");

    if (!accessToken) {
      navigate("/expert/login/social/failure");
    }

    authAxios.defaults.headers.common["Authorization"] = `Bearer ${accessToken}`;

    navigate("/expert/login/identify");
  }, [navigate]);

  return <></>;
}

export default SocialLogin;
