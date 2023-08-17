import { useEffect, useRef, useState } from "react";
import { Bar, Job, Logout, Name, NameBox, ProfileImg, ProfileMenu, ProfileMenuItem, ProfileText } from "./style";

import ArrowDropDownIcon from "@mui/icons-material/ArrowDropDown";
import PersonOutlineOutlinedIcon from "@mui/icons-material/PersonOutlineOutlined";
import { client } from "@/api/aixos";
import { useNavigate } from "react-router-dom";
import { LOGIN_ROUTE } from "@/router/router";

type TProfileProps = {
  job: string;
  name: string;
  imgSrc: string;
};

function Profile({ job, name, imgSrc }: TProfileProps) {
  const [isOpen, setIsOpen] = useState<boolean>(false);
  const [isFirst, setIsFirst] = useState<boolean>(true);

  const profileMenuRef = useRef<HTMLDivElement>(null);

  const navigate = useNavigate();

  useEffect(() => {
    const handleOutOfMenuClick = (e: MouseEvent) => {
      if (profileMenuRef.current) {
        if (!(e.target instanceof Node) || !profileMenuRef.current.contains(e.target)) {
          if (isOpen) {
            setTimeout(() => setIsOpen(false), 20);
          }
        }
      }
    };

    document.addEventListener("mouseup", handleOutOfMenuClick);

    return () => {
      document.removeEventListener("mouseup", handleOutOfMenuClick);
    };
  }, [isOpen, navigate]);

  const handleLogoutClick = () => {
    // eslint-disable-next-line @typescript-eslint/no-empty-function
    let id = window.setTimeout(() => {}, 0);

    while (id--) {
      window.clearTimeout(id);
    }

    client.defaults.headers.common["Authorization"] = "";
    localStorage.setItem("logged", "false");
    navigate(LOGIN_ROUTE);
  };

  return (
    <>
      <ProfileText>
        <Job>{job}</Job>
        <NameBox
          className={isFirst ? "" : isOpen ? "open" : "close"}
          onClick={() => {
            setIsOpen(true);
            setIsFirst(false);
          }}
        >
          <Name>{name}</Name>
          <ArrowDropDownIcon />
        </NameBox>
      </ProfileText>
      <ProfileImg src={imgSrc} />
      {isOpen && (
        <ProfileMenu ref={profileMenuRef}>
          <ProfileMenuItem to="/">
            <PersonOutlineOutlinedIcon />
            <span>내 정보</span>
          </ProfileMenuItem>
          <Bar />
          <Logout onClick={handleLogoutClick}>로그아웃</Logout>
        </ProfileMenu>
      )}
    </>
  );
}

export default Profile;
