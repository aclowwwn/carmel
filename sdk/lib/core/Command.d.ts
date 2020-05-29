import { ICommand, ISession, CommandProps, CommandArg, Target, IScript, IProduct, CommandType } from '..';
/**
 * The base class representing a single unit of execution.
 * Every Carmel Command extends this class and tweaks the defaults as needed.
 *
 * {@link https://github.com/fluidtrends/carmel/blob/master/sdk/src/Command.ts | Source Code } |
 * {@link https://codeclimate.com/github/fluidtrends/carmel/sdk/src/Command.ts/source | Code Quality} |
 * {@link https://codeclimate.com/github/fluidtrends/carmel/sdk/src/Command.ts/stats | Code Stats}
 *
 * @category Core
 */
export declare abstract class Command implements ICommand {
    /** @internal */
    protected _session?: ISession;
    /** @internal */
    protected _args?: CommandArg[];
    /** @internal */
    protected _props: CommandProps;
    /** @internal */
    protected _product?: IProduct;
    /** @internal */
    protected _script?: IScript;
    /**
     * Construct a new command from the given {@linkcode CommandProps}.
     *
     * @param props The {@linkcode CommandsProps} required for building this command
     */
    constructor(props?: CommandProps);
    /**
     *
     */
    get props(): CommandProps;
    /**
     *
     */
    get target(): Target;
    /**
     *
     */
    get id(): string;
    /**
     *
     */
    get type(): CommandType;
    /**
     *
     */
    get script(): IScript | undefined;
    /**
     *
     */
    get requiresArgs(): boolean;
    /**
     *
     */
    get requiresScript(): boolean;
    /**
     *
     */
    get product(): IProduct | undefined;
    /** @internal */
    private _validateArgs;
    /** @internal */
    private _validateProductTypeRequirements;
    /** @internal */
    private _validateTypeRequirements;
    /**
     * Run a command in the given session, this usually gets invoked by
     * the {@linkcode Engine}
     *
     * @param session The {@linkcode Session} in which to run this command
     * @param args The {@linkcode CommandArg} args used to execute this command, if any
     */
    run(session: ISession, args?: CommandArg[]): Promise<void>;
    /**
     * Children need to implement the execution flow.
     *
     * @param session The {@linkcode Session} in which to run this command
     * @param args The {@linkcode CommandArg} args used to execute this command, if any
     */
    abstract exec(session: ISession, args?: CommandArg[]): Promise<void>;
}
