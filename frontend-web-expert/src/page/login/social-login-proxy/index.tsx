import { setCredentials } from "@/store/auth";
import { useEffect } from "react";
import { Cookies } from "react-cookie";
import { useDispatch } from "react-redux";
import { useNavigate } from "react-router-dom";

function SocialLoginProxy() {
  const dispatch = useDispatch();
  const navigate = useNavigate();

  useEffect(() => {
    const cookies = new Cookies();
    const accessToken = cookies.get("accessToken");
    cookies.remove("accessToken", { path: "/" });

    if (!accessToken) {
      navigate("/login");
    }

    dispatch(setCredentials({ token: accessToken }));

    navigate("/");
  }, [dispatch, navigate]);

  return <>kakao login...</>;
}

export default SocialLoginProxy;
