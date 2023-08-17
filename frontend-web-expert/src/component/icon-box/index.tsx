import { Outer, SwingIconButton, SmallBadge } from "./style";

import NotificationsNoneOutlinedIcon from "@mui/icons-material/NotificationsNoneOutlined";

function IconBox() {
  const notificationsLabel = (count: number) => {
    if (count === 0) {
      return "no notifications";
    }
    if (count > 99) {
      return "more than 99 notifications";
    }
    return `${count} notifications`;
  };

  return (
    <Outer>
      <SwingIconButton aria-label={notificationsLabel(100)}>
        <SmallBadge
          badgeContent={100}
          color="error"
          max={99}
          anchorOrigin={{
            vertical: "bottom",
            horizontal: "right",
          }}
        >
          <NotificationsNoneOutlinedIcon />
        </SmallBadge>
      </SwingIconButton>
    </Outer>
  );
}

export default IconBox;
