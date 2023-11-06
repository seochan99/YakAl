import * as S from "./style.ts";
import { DialogActions, DialogTitle } from "@mui/material";

type TApprovalDialog = {
  title: string;
  isOpen: boolean;
  onClose: () => void;
  onClickOkay: () => void;
  hasReasonForm: boolean;
  reason?: string;
  onChangeReason?: (event: React.ChangeEvent<HTMLTextAreaElement>) => void;
};

function ApprovalDialog({
  title,
  isOpen,
  onClose,
  onClickOkay, // hasReasonForm,
} // reason,
// onChangeReason,
: TApprovalDialog) {
  return (
    <S.StyledDialog open={isOpen} onClose={onClose} aria-labelledby="approval-dialog">
      <DialogTitle>{title}</DialogTitle>
      <DialogActions>
        <S.CancelButton onClick={onClose}>{"취소"}</S.CancelButton>
        <S.OkayButton onClick={onClickOkay}>{"확인"}</S.OkayButton>
      </DialogActions>
    </S.StyledDialog>
  );
}

export default ApprovalDialog;
