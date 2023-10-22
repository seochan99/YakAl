import { SyntheticEvent, useCallback, useState } from "react";
import { SnackbarCloseReason } from "@mui/material";

const useSnackbar = () => {
  const [open, setOpen] = useState<boolean>(false);

  const openSnackbar = useCallback(() => {
    setOpen(true);
  }, [setOpen]);

  const onClose = useCallback(
    (_event: Event | SyntheticEvent<any, Event>, reason?: SnackbarCloseReason) => {
      if (reason === "clickaway") {
        return;
      }
      setOpen(false);
    },
    [setOpen],
  );

  return { open, setOpen, onClose, openSnackbar };
};

export default useSnackbar;
