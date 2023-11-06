import { Alert, Slide, SlideProps, Snackbar, SnackbarCloseReason } from "@mui/material";
import React, { SyntheticEvent, useCallback } from "react";
import { ESnackbarType } from "@type/enum/snackbar-type.ts";

type YakalSnackbarProps = {
  open: boolean;
  setOpen: React.Dispatch<React.SetStateAction<boolean>>;
  type: ESnackbarType;
};

function YakalSnackbar({ open, setOpen, type }: YakalSnackbarProps) {
  const onClose = useCallback(
    (_event: Event | SyntheticEvent<any, Event>, reason?: SnackbarCloseReason) => {
      if (reason === "clickaway") {
        return;
      }

      setOpen(false);
    },
    [setOpen],
  );

  return (
    <Snackbar
      open={open}
      autoHideDuration={2000}
      onClose={onClose}
      anchorOrigin={{ vertical: "bottom", horizontal: "center" }}
      TransitionComponent={(props: SlideProps) => <Slide {...props} direction="up" children={props.children} />}
    >
      <Alert onClose={onClose} severity="error" elevation={6} variant="filled">
        {type}
      </Alert>
    </Snackbar>
  );
}

export default React.memo(YakalSnackbar);
