interface ModalProps {
    title: string;
    description: string;
    accept: string;
    decline: string;
    handleAccept: () => Promise<void> | void;
    handleDecline: () => Promise<void> | void;
}
declare const Modal: ({ title, description, accept, decline, handleAccept, handleDecline }: ModalProps) => JSX.Element;
export default Modal;
