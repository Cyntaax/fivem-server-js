declare type Deferral = {
	defer(): void;
	update(message: string): void;
	presentCard(card: any, cb?: (data: any, rawData: string) => void): void;
	done(failureReason?: string): void;
};

declare type KickFunc = (reason?: string) => void;

declare type BanInfo = {
	until: number;
	reason: string;
	by: string;
};
