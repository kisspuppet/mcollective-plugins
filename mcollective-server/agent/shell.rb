module MCollective
 module Agent
  class Shell<RPC::Agent

    metadata    :name        => "Shell Command",
                :description => "Remote execution of bash commands",
                :author      => "Jeremy Carroll",
                :license     => "Apache v.2",
                :version     => "1.0",
                :url         => "http://github.com/phobos182/mcollective-plugins",
                :timeout     => 300

    action "execute" do
        validate :cmd, String

        out = []
        err = ""

        begin
          status = run("#{request[:cmd]}", :stdout => out, :stderr => err, :chomp => true)
        rescue Exception => e
          reply.fail e.to_s
        end

        reply[:exitcode] = status
        reply[:stdout] = out.join(" ")
        reply[:stderr] = err
        reply.fail err if status != 0
    end

  end
 end
end
